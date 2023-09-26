#import "BxlMPosControllerPrinterPlugin.h"
//#import "MPosControllerPrinter.h"
//#import "MPosResults.h"
//#import "MPosDefines.h"
@import frameworkMPosSDK;

static NSString* const PLATFORM_CHANNEL = @"com.bixolon.mposcontroller/printer";
static NSString* const STATUS_EVENT_CHANNEL = @"com.bixolon.mposcontroller/printer/status";
static NSString* const OUTPUT_COMPLETE_EVENT_CHANNEL = @"com.bixolon.mposcontroller/printer/outputcompleted";

@interface PrinterStatusUpdateEvent : NSObject<FlutterStreamHandler>
@property(weak) BxlMPosControllerPrinterPlugin* plugin;
@property FlutterEventSink eventSink;
@end

@implementation PrinterStatusUpdateEvent

- (id)initWithPlugin:(BxlMPosControllerPrinterPlugin*)plugin{
    if((self=[super init])){
        self.plugin = plugin;
        NSNotificationCenter* defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(deviceNotificationHandler:) name: @"StatusUpdateEvent" object:nil];
    }
    return self;
}

- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(FlutterEventSink)events{
    self.eventSink = events;
    return nil;
}

- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments{
    self.eventSink = nil;
    return nil;
}

- (void) deviceNotificationHandler:(NSNotification*) notification {
    if(self.plugin == NULL)
        return;
    NSNumber* deviceId = (NSNumber*)[notification object];
    if([deviceId integerValue] != [self.plugin getDeviceID])
        return;
    if ([[notification name] isEqualToString: @"StatusUpdateEvent"]){
        NSMutableArray *allKeys = [[[notification userInfo] allKeys] mutableCopy];
        for (NSString *key in allKeys) {
            NSInteger status = [[[notification userInfo] objectForKey: key] integerValue];
            if(self.eventSink != nil)
                self.eventSink([NSNumber numberWithInteger:status]);
        }
    }
}
@end

@interface PrinterOuputCompletedEvent : NSObject<FlutterStreamHandler>
@property(weak) BxlMPosControllerPrinterPlugin* plugin;
@property FlutterEventSink eventSink;
@end

@implementation PrinterOuputCompletedEvent

- (id)initWithPlugin:(BxlMPosControllerPrinterPlugin*)plugin{
    if((self=[super init])){
        self.plugin = plugin;
        NSNotificationCenter* defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(deviceNotificationHandler:) name: @"OutputCompletedEvent" object:nil];
    }
    return self;
}

- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(FlutterEventSink)events{
    self.eventSink = events;
    return nil;
}

- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments{
    self.eventSink = nil;
    return nil;
}

- (void) deviceNotificationHandler:(NSNotification*) notification {
    if(self.plugin == NULL)
        return;
    NSNumber* deviceId = (NSNumber*)[notification object];
    if([deviceId integerValue] != [self.plugin getDeviceID])
        return;
    if ([[notification name] isEqualToString: @"OutputCompletedEvent"]){
        if(self.eventSink != nil)
            self.eventSink(nil);
    }
}
@end



@interface BxlMPosControllerPrinterPlugin()
@property MPosControllerPrinter* printer;
@property FlutterEventSink eventSink;
@end

@implementation BxlMPosControllerPrinterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName: PLATFORM_CHANNEL
                                     binaryMessenger:[registrar messenger]];
    
    BxlMPosControllerPrinterPlugin* instance = [[BxlMPosControllerPrinterPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    // CHANNEL: PRINTER STATUS
    FlutterEventChannel* eventChannel = [FlutterEventChannel
                                         eventChannelWithName:STATUS_EVENT_CHANNEL
                                         binaryMessenger: [registrar messenger]];
    [eventChannel setStreamHandler:[[PrinterStatusUpdateEvent alloc] initWithPlugin:instance]];
    
    // CHANNEL: OUTPUT COMPLETED EVENT
    eventChannel = [FlutterEventChannel
                    eventChannelWithName:OUTPUT_COMPLETE_EVENT_CHANNEL
                    binaryMessenger: [registrar messenger]];
    [eventChannel setStreamHandler:[[PrinterOuputCompletedEvent alloc] initWithPlugin:instance]];
}

- (id)init{
    [MPosControllerPrinter setEnableLog:YES saveFile:NO saveToHex:NO];
    if((self=[super init])){
        self.printer = [MPosControllerPrinter new];
    }
    return self;
}

- (NSInteger)getDeviceID {
    return [self.printer getDeviceId];
}
    
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    // Common APIs
    if ([@"openService" isEqualToString:call.method])                       return [self openService:call result: result];
    else if ([@"closeService" isEqualToString:call.method])                 return [self closeService:call result: result];
    else if ([@"selectInterface" isEqualToString:call.method])              return [self selectInterface:call result: result];
    else if ([@"selectCommandMode" isEqualToString:call.method])            return [self selectCommandMode:call result: result];
    else if ([@"setTransaction" isEqualToString:call.method])               return [self setTransaction:call result: result];
    else if ([@"directIO" isEqualToString:call.method])                     return [self directIO:call result: result];
    else if ([@"isOpen" isEqualToString:call.method])                       return [self isOpen:call result: result];
    else if ([@"setReadMode" isEqualToString:call.method])                  return [self setReadMode:call result: result];
    else if ([@"setKeepNetworkConnection" isEqualToString:call.method])     return [self setKeepNetworkConnection:call result: result];
    // Printer APIs
    else if ([@"printText" isEqualToString:call.method])                    return [self printText:call result: result];
    else if ([@"setCharacterset" isEqualToString:call.method])              return [self setCharacterset:call result: result];
    else if ([@"setInternationalCharacterset" isEqualToString:call.method]) return [self setInternationalCharacterset:call result: result];
    else if ([@"setPagemode" isEqualToString:call.method])                  return [self setPagemode:call result: result];
    else if ([@"setPagemodePrintArea" isEqualToString:call.method])         return [self setPagemodePrintArea:call result: result];
    else if ([@"setPagemodeDirection" isEqualToString:call.method])         return [self setPagemodeDirection:call result: result];
    else if ([@"setPagemodePosition" isEqualToString:call.method])          return [self setPagemodePosition:call result: result];
    else if ([@"printImageFile" isEqualToString:call.method])               return [self printImageFile:call result: result];
    else if ([@"printBase64Image" isEqualToString:call.method])             return [self printBase64Image:call result: result];
    else if ([@"printPDFFile" isEqualToString:call.method])                 return [self printPDFFile:call result: result];
    else if ([@"print1DBarcode" isEqualToString:call.method])               return [self print1DBarcode:call result: result];
    else if ([@"printQRCode" isEqualToString:call.method])                  return [self printQRCode:call result: result];
    else if ([@"printPDF417" isEqualToString:call.method])                  return [self printPDF417:call result: result];
    else if ([@"printDataMatrix" isEqualToString:call.method])              return [self printDataMatrix:call result: result];
    else if ([@"printGS1Databar" isEqualToString:call.method])              return [self printGS1Databar:call result: result];
    else if ([@"printGS1DatabarMobile" isEqualToString:call.method])        return [self printGS1DatabarMobile:call result: result];
    else if ([@"printCompositeSymbology" isEqualToString:call.method])      return [self printCompositeSymbology:call result: result];
    else if ([@"printMaxicode" isEqualToString:call.method])                return [self printMaxicode:call result: result];
    else if ([@"printAztec" isEqualToString:call.method])                   return [self printAztec:call result: result];
    else if ([@"printLine" isEqualToString:call.method])                    return [self printLine:call result: result];
    else if ([@"printBox" isEqualToString:call.method])                     return [self printBox:call result: result];
    else if ([@"checkPrinterStatus" isEqualToString:call.method])           return [self checkPrinterStatus:call result: result];
    else if ([@"checkBattStatus" isEqualToString:call.method])              return [self checkBattStatus:call result: result];
    else if ([@"asbEnable" isEqualToString:call.method])                    return [self asbEnable:call result: result];
    else if ([@"cutPaper" isEqualToString:call.method])                     return [self cutPaper:call result: result];
    else if ([@"openDrawer" isEqualToString:call.method])                   return [self openDrawer:call result: result];
    else if ([@"getModelName" isEqualToString:call.method])                 return [self getModelName:call result: result];
    else if ([@"getFirmwareVersion" isEqualToString:call.method])           return [self getFirmwareVersion:call result: result];
    else if ([@"getStatisticsData" isEqualToString:call.method])            return [self getStatisticsData:call result: result];
    // MSR
    else if ([@"msrReady" isEqualToString:call.method])                     return [self msrReady:call result: result];
    else if ([@"getTrack1Data" isEqualToString:call.method])                return [self getTrack1Data:call result: result];
    else if ([@"getTrack2Data" isEqualToString:call.method])                return [self getTrack2Data:call result: result];
    else if ([@"getTrack3Data" isEqualToString:call.method])                return [self getTrack3Data:call result: result];
    // SCR
    else if ([@"powerUpSCR" isEqualToString:call.method])                   return [self powerUpSCR:call result: result];
    else if ([@"powerDownSCR" isEqualToString:call.method])                 return [self powerDownSCR:call result: result];
    else if ([@"setSCROperationMode" isEqualToString:call.method])          return [self setSCROperationMode:call result: result];
    else if ([@"setSCRCardType" isEqualToString:call.method])               return [self setSCRCardType:call result: result];
    else if ([@"exchangeSCRData" isEqualToString:call.method])              return [self exchangeSCRData:call result: result];
    else if ([@"getSCRCardStatus" isEqualToString:call.method])             return [self getSCRCardStatus:call result: result];
    // BCD connected with printer
    else if ([@"displayString" isEqualToString:call.method])                return [self displayString:call result: result];
    else if ([@"clearScreen" isEqualToString:call.method])                  return [self clearScreen:call result: result];
    else if ([@"storeImageFile" isEqualToString:call.method])               return [self storeImageFile:call result: result];
    else if ([@"storeBase64Image" isEqualToString:call.method])             return [self storeBase64Image:call result: result];
    else if ([@"displayImage" isEqualToString:call.method])                 return [self displayImage:call result: result];
    else if ([@"clearImage" isEqualToString:call.method])                   return [self clearImage:call result: result];
    else if ([@"showCursor" isEqualToString:call.method])                   return [self showCursor:call result: result];
    else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)openService:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* deviceId = arguments[@"device_id"] ? : @-1;
    NSNumber* timeout = arguments[@"time_out"] ? : @3;
    MPOS_RESULT nativeResult = [self.printer openService:[deviceId integerValue] timeout:[timeout integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)closeService:(FlutterMethodCall*)call result:(FlutterResult)result {
    self.eventSink = nil;
    NSDictionary* arguments = [call arguments];
    NSNumber* timeout = arguments[@"time_out"] ? : @3;
    MPOS_RESULT nativeResult = [self.printer closeService:[timeout integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)selectInterface:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* interfaceType = arguments[@"interface_type"] ? : @-1;
    NSString* address = arguments[@"address"] ? : @3;
    MPOS_RESULT nativeResult = [self.printer selectInterface:[interfaceType integerValue] address:address];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)selectCommandMode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* commandMode = arguments[@"command_mode"] ? : @-1;
    MPOS_RESULT nativeResult = [self.printer selectCommandMode:[commandMode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setTransaction:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* transaction = arguments[@"transaction"] ? : @-1;
    MPOS_RESULT nativeResult = [self.printer setTransaction:[transaction integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setReadMode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* mode = arguments[@"read_mode"] ? : @-1;
    MPOS_RESULT nativeResult = [self.printer setReadMode:[mode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)directIO:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSArray<NSNumber*>* data = arguments[@"data_array"] ? : @[];
    
    NSMutableData* dataToSend = [NSMutableData data];
    for(NSNumber* number in data){
        char byte = [number charValue];
        [dataToSend appendBytes: &byte length:1];
    }
    MPOS_RESULT nativeResult = [self.printer directIO:dataToSend];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)isOpen:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.printer isOpen] ? 1 : 0;
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setKeepNetworkConnection:(FlutterMethodCall*)call result:(FlutterResult)result {
    if(![self.printer isOpen]){
        NSDictionary* arguments = [call arguments];
        NSNumber* keep_connection = arguments[@"keep_connection"] ? : @0;
        [self.printer setKeepNetworkConnection:[keep_connection integerValue]];
        result([NSNumber numberWithInteger: 0]);
    }else{
        result([NSNumber numberWithInteger: 1000]);
    }
}

- (void)printText:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* fontType = arguments[@"font_type"] ? : @0;
    NSNumber* fontWidth = arguments[@"font_width"] ? : @0;
    NSNumber* fontHeight = arguments[@"font_height"] ? : @0;
    NSNumber* bold = arguments[@"bold"] ? : @0;
    NSNumber* underline = arguments[@"underline"] ? : @0;
    NSNumber* reverse = arguments[@"reverse"] ? : @0;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer printText:data
                                              fontType:[fontType integerValue]
                                             fontWidth:[fontWidth integerValue]
                                            fontHeight:[fontHeight integerValue]
                                                  bold:[bold integerValue]
                                             underline:[underline integerValue]
                                               reverse:[reverse integerValue]
                                             alignment:[alignment integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setCharacterset:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* characterset = arguments[@"character_set"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setCharacterset:[characterset integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setInternationalCharacterset:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* characterset = arguments[@"character_set"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setInternationalCharacterset:[characterset integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setPagemode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* mode = arguments[@"mode"] ? : [NSNumber numberWithInt:-1];
    MPOS_RESULT nativeResult = [self.printer setPagemode:[mode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setPagemodePrintArea:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* x = arguments[@"x"] ? : @0;
    NSNumber* y = arguments[@"y"] ? : @0;
    NSNumber* width = arguments[@"width"] ? : @0;
    NSNumber* height = arguments[@"height"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setPagemodePrintArea:[x integerValue]
                                                                y:[y integerValue]
                                                            width:[width integerValue]
                                                           height:[height integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setPagemodeDirection:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* direction = arguments[@"direction"] ? : [NSNumber numberWithInt:-1];
    MPOS_RESULT nativeResult = [self.printer setPagemodeDirection:[direction integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setPagemodePosition:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* x = arguments[@"x"] ? : @0;
    NSNumber* y = arguments[@"y"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setPagemodePosition:[x integerValue] y:[y integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printImageFile:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* fileName = arguments[@"file_name"] ? : @"";
    NSNumber* width = arguments[@"width"] ? : @-1;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* threshold = arguments[@"threshold"] ? : @128;
    NSNumber* ditheringType = arguments[@"dithering_type"] ? : @1;
    NSNumber* compressType = arguments[@"compress_type"] ? : @1;
    MPOS_RESULT nativeResult = [self.printer printImageFile:fileName
                                                      width:[width integerValue]
                                                  alignment:[alignment integerValue]
                                                  threshold:[threshold integerValue]
                                              ditheringType:[ditheringType integerValue]
                                               compressType:[compressType integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printBase64Image:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* width = arguments[@"width"] ? :@-1;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* threshold = arguments[@"threshold"] ? : @128;
    NSNumber* ditheringType = arguments[@"dithering_type"] ? : @1;
    NSNumber* compressType = arguments[@"compress_type"] ? : @1;
    MPOS_RESULT nativeResult = [self.printer printBase64Image:data
                                                        width:[width integerValue]
                                                    alignment:[alignment integerValue]
                                                    threshold:[threshold integerValue]
                                                ditheringType:[ditheringType integerValue]
                                                 compressType:[compressType integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printPDFFile:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* fileName = arguments[@"file_name"] ? : @"";
    NSNumber* width = arguments[@"width"] ? : @-1;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* startPage = arguments[@"start_page"] ? : @0;
    NSNumber* endPage = arguments[@"end_page"] ? : @0;
    NSNumber* threshold = arguments[@"threshold"] ? : @128;
    NSNumber* ditheringType = arguments[@"dithering_type"] ? : @0;
    NSNumber* compressType = arguments[@"compress_type"] ? : @1;
    MPOS_RESULT nativeResult = [self.printer printPDFFile:fileName
                                                    width:[width integerValue]
                                                alignment:[alignment integerValue]
                                                startPage:[startPage integerValue]
                                                  endPage:[endPage integerValue]
                                                threshold:[threshold integerValue]
                                            ditheringType:[ditheringType integerValue]
                                             compressType:[compressType integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)print1DBarcode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* symbology = arguments[@"symbol"] ? : @0;
    NSNumber* width = arguments[@"width"] ? : @-1;
    NSNumber* height = arguments[@"height"] ? : @-1;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* textPosition = arguments[@"text_position"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer print1DBarcode:data
                                                  symbology:[symbology integerValue]
                                                      width:[width integerValue]
                                                     height:[height integerValue]
                                                  alignment:[alignment integerValue]
                                                textPostion:[textPosition integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printQRCode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* model = arguments[@"model"] ? : @0;
    NSNumber* moduleSize = arguments[@"module_size"] ? : @-1;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* eccLevel = arguments[@"ecc_level"] ? : @-1;
    
    MPOS_RESULT nativeResult = [self.printer printQRCode:data
                                                   model:[model integerValue]
                                               alignment:[alignment integerValue]
                                              moduleSize:[moduleSize integerValue]
                                                eccLevel:[eccLevel integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printPDF417:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* symbol = arguments[@"symbol"] ? : @0;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* columnNumber = arguments[@"column_number"] ? : @-1;
    NSNumber* rowNumber = arguments[@"row_number"] ? : @-1;
    NSNumber* moduleWidth = arguments[@"module_width"] ? : @-1;
    NSNumber* moduleHeight = arguments[@"module_height"] ? : @-1;
    NSNumber* eccLevel = arguments[@"ecc_level"] ? : @-1;
    
    MPOS_RESULT nativeResult = [self.printer printPDF417:data
                                                  symbol:[symbol integerValue]
                                               alignment:[alignment integerValue]
                                            columnNumber:[columnNumber integerValue]
                                               rowNumber:[rowNumber integerValue]
                                             moduleWidth:[moduleWidth integerValue]
                                            moduleHeight:[moduleHeight integerValue]
                                                eccLevel:[eccLevel integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printDataMatrix:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* moduleSize = arguments[@"module_size"] ? : @0;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    
    MPOS_RESULT nativeResult = [self.printer printDataMatrix:data
                                                   alignment:[alignment integerValue]
                                                  moduleSize:[moduleSize integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printGS1Databar:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* symbol = arguments[@"symbol"] ? : @72;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* size = arguments[@"size"] ? : @4;
    MPOS_RESULT nativeResult = [self.printer printGS1Databar:data
                                                      symbol:[symbol integerValue]
                                                   alignment:[alignment integerValue]
                                                  moduleSize:[size integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printGS1DatabarMobile:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSString* cData = arguments[@"c_data"] ? : @"";
    NSNumber* symbol = arguments[@"symbol"] ? : @50;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* moduleWidth = arguments[@"module_width"] ? : @2;
    NSNumber* moduleHeight = arguments[@"module_height"] ? : @2;
    NSNumber* segmentHeight = arguments[@"segment_height"] ? : @1;
    NSNumber* separatorHeight = arguments[@"separator_height"] ? : @2;
    MPOS_RESULT nativeResult = [self.printer printGS1DatabarMobile:data
                                                             cData:cData
                                                            symbol:[symbol integerValue]
                                                         alignment:[alignment integerValue]
                                                       moduleWidth:[moduleWidth integerValue]
                                                      moduleHeight:[moduleHeight integerValue]
                                                     segmentHeight:[segmentHeight integerValue]
                                                   separatorHeight:[separatorHeight integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printCompositeSymbology:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSString* cData = arguments[@"c_data"] ? : @"";
    NSNumber* symbol = arguments[@"symbol"] ? : @65;
    NSNumber* cSymbol = arguments[@"c_symbol"] ? : @65;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* size = arguments[@"size"] ? : @2;
    MPOS_RESULT nativeResult = [self.printer printCompositeSymbology:data
                                                               cData:cData
                                                              symbol:[symbol integerValue]
                                                             cSymbol:[cSymbol integerValue]
                                                           alignment:[alignment integerValue]
                                                                size:[size integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printMaxicode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* mode = arguments[@"mode"] ? : @50;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer printMaxicode:data
                                                      mode:[mode integerValue]
                                                 alignment:[alignment integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printAztec:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    NSNumber* moduleSize = arguments[@"module_size"] ? : @4;
    NSNumber* eccLevel = arguments[@"ecc_level"] ? : @48;
    NSNumber* mode = arguments[@"mode"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer printAztec:data
                                              alignment:[alignment integerValue]
                                             moduleSize:[moduleSize integerValue]
                                               eccLevel:[eccLevel integerValue]
                                                   mode:[mode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}


- (void)printLine:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* x1 = arguments[@"x1"] ? : @0;
    NSNumber* y1 = arguments[@"y1"] ? : @0;
    NSNumber* x2 = arguments[@"x2"] ? : @0;
    NSNumber* y2 = arguments[@"y2"] ? : @0;
    NSNumber* thickness = arguments[@"thickness"] ? : [NSNumber numberWithInt:0];
    
    MPOS_RESULT nativeResult = [self.printer printLine:[x1 integerValue]
                                                    y1:[y1 integerValue]
                                                    x2:[x2 integerValue]
                                                    y2:[y2 integerValue]
                                             thickness:[thickness integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printBox:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* x1 = arguments[@"left"] ? : @0;
    NSNumber* y1 = arguments[@"top"] ? : @0;
    NSNumber* x2 = arguments[@"right"] ? : @0;
    NSNumber* y2 = arguments[@"bottom"] ? : @0;
    NSNumber* thickness = arguments[@"thickness"] ? : @0;
    
    MPOS_RESULT nativeResult = [self.printer printBox:[x1 integerValue]
                                                    y1:[y1 integerValue]
                                                    x2:[x2 integerValue]
                                                    y2:[y2 integerValue]
                                             thickness:[thickness integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)cutPaper:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* cutType = arguments[@"cut_type"] ? : @65;
    
    MPOS_RESULT nativeResult = [self.printer cutPaper:[cutType integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)openDrawer:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* pin = arguments[@"pin_number"] ? : @0;
    NSNumber* ontime = arguments[@"on_time"] ? : @0;
    NSNumber* offtime = arguments[@"off_time"] ? : @0;
    
    MPOS_RESULT nativeResult = [self.printer openDrawer:[pin integerValue]
                                            onTimePulse:[ontime integerValue]
                                           offTimePulse:[offtime integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)getModelName:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* nativeResult = [self.printer getModelName];
    result(nativeResult);
}

- (void)getFirmwareVersion:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* nativeResult = [self.printer getFirmwareVersion];
    result(nativeResult);
}

- (void)asbEnable:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* enable = arguments[@"enable"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer asbEnable:[enable integerValue] > 0];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)checkPrinterStatus:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.printer checkPrinterStatus];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)checkBattStatus:(FlutterMethodCall*)call result:(FlutterResult)result {
    __block NSInteger status = -1;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self.printer checkBattStatus:^(NSInteger battStatus) {
        status = battStatus;
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    result([NSNumber numberWithInteger:status]);
}

- (void)getStatisticsData:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* info = arguments[@"request_info"] ? : @0;
    NSString* nativeResult = [self.printer getStatisticsData:[info integerValue]];
    result(nativeResult);
}

- (void)displayString:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* characterset = arguments[@"character_set"] ? : @0;
    NSNumber* intCharacterset = arguments[@"international_character_set"] ? : @0;
    NSNumber* line = arguments[@"line"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer displayString:data
                                                  codePage:[characterset integerValue]
                                 internationalCharacterSet:[intCharacterset integerValue]
                                                      line:[line integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)clearScreen:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.printer clearScreen];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)storeImageFile:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* fileName = arguments[@"file_name"];
    NSNumber* width = arguments[@"width"] ? : @-1;
    NSNumber* imageNumber = arguments[@"image_number"] ? : @-1;
    MPOS_RESULT nativeResult = [self.printer storeImageFile:fileName
                                                      width:[width integerValue]
                                                imageNumber:[imageNumber integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)storeBase64Image:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"];
    NSNumber* width = arguments[@"width"] ? :@-1;
    NSNumber* imageNumber = arguments[@"image_number"] ? : @-1;
    MPOS_RESULT nativeResult = [self.printer storeBase64Image:data
                                                        width:[width integerValue]
                                                  imageNumber:[imageNumber integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)displayImage:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* imageNumber = arguments[@"image_number"] ? : @-1;
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer displayIamge:[imageNumber integerValue]
                                                     xPos:[xPosition integerValue]
                                                     yPos:[yPosition integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)clearImage:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* imageNumber = arguments[@"image_number"] ? : @-1;
    MPOS_RESULT nativeResult = [self.printer clearIamge:[imageNumber integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)showCursor:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* cursor = arguments[@"show_cursor"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer showCursor:[cursor integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)msrReady:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.printer msrReady];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)getTrack1Data:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* nativeResult = [self.printer getTrack1Data];
    result(nativeResult);
}

- (void)getTrack2Data:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* nativeResult = [self.printer getTrack2Data];
    result(nativeResult);
}

- (void)getTrack3Data:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* nativeResult = [self.printer getTrack3Data];
    result(nativeResult);
}

- (void)powerUpSCR:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSData* scrData = nil;
    [self.printer powerUpSCR:&scrData];
    NSMutableArray<NSNumber*>* array = [NSMutableArray<NSNumber*> array];
    if([scrData length] > 0){
        const char* data = scrData.bytes;
        for(int i = 0; i < scrData.length; i++)
            [array addObject:[NSNumber numberWithInt:(int)data[i]]];
    }
    result([array copy]);
}

- (void)powerDownSCR:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.printer powerDownSCR];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setSCROperationMode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* mode = arguments[@"mode"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setSCROperationMode:[mode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setSCRCardType:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* cardType = arguments[@"card_type"] ? : @48;
    MPOS_RESULT nativeResult = [self.printer setSCRCardType:[cardType integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)exchangeSCRData:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSArray<NSNumber*>* data = arguments[@"data_array"] ? : @[];
    
    NSMutableData* dataToSend = [NSMutableData data];
    for(NSNumber* number in data){
        char byte = [number charValue];
        [dataToSend appendBytes: &byte length:1];
    }
    
    NSData* scrData = nil;
    [self.printer exchangeSCRData:dataToSend response:&scrData];
    NSMutableArray<NSNumber*>* array = [NSMutableArray<NSNumber*> array];
    if([scrData length] > 0){
        const char* data = scrData.bytes;
        for(int i = 0; i < scrData.length; i++)
            [array addObject:[NSNumber numberWithInt:(int)data[i]]];
    }
    result([array copy]);
}

- (void)getSCRCardStatus:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSData* scrData = nil;
    [self.printer getSCRCardStatus:&scrData];
    if([scrData length] > 0){
        const char* bytes = scrData.bytes;
        result([NSNumber numberWithInteger: bytes[0]]);
        return;
    }
    result([NSNumber numberWithInteger: -1]);
}

- (NSString*) convertJSONString:(NSData*) resData {
    if(![resData length]){
        return @"[]";
    }
    NSString* dataInJSON = @"";
    const char* bytes = resData.bytes;
    dataInJSON = [dataInJSON stringByAppendingString: @"[{"];
    for (int index = 0; index < resData.length; index++) {
        NSString* keyWithValue = [NSString stringWithFormat:@"\"%d\":%d,", index, bytes[index]];
        dataInJSON = [dataInJSON stringByAppendingString: keyWithValue];
    }
    dataInJSON = [dataInJSON substringToIndex:[dataInJSON length]-1];
    dataInJSON = [dataInJSON stringByAppendingString: @"}]"];
    return dataInJSON;
}

@end
