#import "BxlMPosControllerLabelPrinterPlugin.h"
//#import "MPosControllerLabelPrinter.h"
//#import "MPosResults.h"
//#import "MPosDefines.h"
@import frameworkMPosSDK;

static NSString* const PLATFORM_CHANNEL = @"com.bixolon.mposcontroller/labelprinter";
static NSString* const OUTPUT_COMPLETE_EVENT_CHANNEL = @"com.bixolon.mposcontroller/labelprinter/outputcompleted";

@interface LabelPrinterOuputCompletedEvent : NSObject<FlutterStreamHandler>
@property(weak) BxlMPosControllerLabelPrinterPlugin* plugin;
@property FlutterEventSink eventSink;
@end

@implementation LabelPrinterOuputCompletedEvent

- (id)initWithPlugin:(BxlMPosControllerLabelPrinterPlugin*)plugin{
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


@interface BxlMPosControllerLabelPrinterPlugin()
@property MPosControllerLabelPrinter* printer;
@property FlutterEventSink eventSink;
@end

@implementation BxlMPosControllerLabelPrinterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName: PLATFORM_CHANNEL
                                     binaryMessenger:[registrar messenger]];
    
    BxlMPosControllerLabelPrinterPlugin* instance = [[BxlMPosControllerLabelPrinterPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    // CHANNEL: OUTPUT COMPLETED EVENT
    FlutterEventChannel* eventChannel = [FlutterEventChannel
                                         eventChannelWithName:OUTPUT_COMPLETE_EVENT_CHANNEL
                                         binaryMessenger: [registrar messenger]];
    [eventChannel setStreamHandler:[[LabelPrinterOuputCompletedEvent alloc] initWithPlugin:instance]];
}

- (id)init{
    [MPosControllerLabelPrinter setEnableLog:YES saveFile:NO saveToHex:NO];
    if((self=[super init])){
        self.printer = [MPosControllerLabelPrinter new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceNotificationHandler:) name: @"OutputCompletedEvent" object:nil];
    }
    return self;
}

- (MPosControllerDevices*)getDevice {
    return self.printer;
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
    else if ([@"setCharacterset" isEqualToString:call.method])              return [self setCharacterset:call result: result];
    else if ([@"checkPrinterStatus" isEqualToString:call.method])           return [self checkPrinterStatus:call result: result];
    else if ([@"printBuffer" isEqualToString:call.method])                  return [self printBuffer:call result: result];
    else if ([@"drawTextDeviceFont" isEqualToString:call.method])           return [self drawTextDeviceFont:call result: result];
    else if ([@"drawTextVectorFont" isEqualToString:call.method])           return [self drawTextVectorFont:call result: result];
    else if ([@"drawBarcode1D" isEqualToString:call.method])                return [self drawBarcode1D:call result: result];
    else if ([@"drawBarcodeMaxiCode" isEqualToString:call.method])          return [self drawBarcodeMaxiCode:call result: result];
    else if ([@"drawBarcodePDF417" isEqualToString:call.method])            return [self drawBarcodePDF417:call result: result];
    else if ([@"drawBarcodeQRCode" isEqualToString:call.method])            return [self drawBarcodeQRCode:call result: result];
    else if ([@"drawBarcodeDataMatrix" isEqualToString:call.method])        return [self drawBarcodeDataMatrix:call result: result];
    else if ([@"drawBarcodeAztec" isEqualToString:call.method])             return [self drawBarcodeAztec:call result: result];
    else if ([@"drawBarcodeCode49" isEqualToString:call.method])            return [self drawBarcodeCode49:call result: result];
    else if ([@"drawBarcodeCodaBlock" isEqualToString:call.method])         return [self drawBarcodeCodaBlock:call result: result];
    else if ([@"drawBarcodeMicroPDF" isEqualToString:call.method])          return [self drawBarcodeMicroPDF:call result: result];
    else if ([@"drawBarcodeIMB" isEqualToString:call.method])               return [self drawBarcodeIMB:call result: result];
    else if ([@"drawBarcodeMSI" isEqualToString:call.method])               return [self drawBarcodeMSI:call result: result];
    else if ([@"drawBarcodePlessey" isEqualToString:call.method])           return [self drawBarcodePlessey:call result: result];
    else if ([@"drawBarcodeTLC39" isEqualToString:call.method])             return [self drawBarcodeTLC39:call result: result];
    else if ([@"drawBarcodeRSS" isEqualToString:call.method])               return [self drawBarcodeRSS:call result: result];
    else if ([@"drawBlock" isEqualToString:call.method])                    return [self drawBlock:call result: result];
    else if ([@"drawCircle" isEqualToString:call.method])                   return [self drawCircle:call result: result];
    else if ([@"drawBase64Image" isEqualToString:call.method])              return [self drawBase64Image:call result: result];
    else if ([@"drawImageFile" isEqualToString:call.method])                return [self drawImageFile:call result: result];
    else if ([@"drawPDFFile" isEqualToString:call.method])                  return [self drawPDFFile:call result: result];
    else if ([@"setPrintingType" isEqualToString:call.method])              return [self setPrintingType:call result: result];
    else if ([@"setMargin" isEqualToString:call.method])                    return [self setMargin:call result: result];
    else if ([@"setLength" isEqualToString:call.method])                    return [self setLength:call result: result];
    else if ([@"setWidth" isEqualToString:call.method])                     return [self setWidth:call result: result];
    else if ([@"setSpeed" isEqualToString:call.method])                     return [self setSpeed:call result: result];
    else if ([@"setDensity" isEqualToString:call.method])                   return [self setDensity:call result: result];
    else if ([@"setOrientation" isEqualToString:call.method])               return [self setOrientation:call result: result];
    else if ([@"setOffset" isEqualToString:call.method])                    return [self setOffset:call result: result];
    else if ([@"setCuttingPosition" isEqualToString:call.method])           return [self setCuttingPosition:call result: result];
    else if ([@"setAutoCutter" isEqualToString:call.method])                return [self setAutoCutter:call result: result];
    else if ([@"setRewinder" isEqualToString:call.method])                  return [self setRewinder:call result: result];
    else if ([@"getModelName" isEqualToString:call.method])                 return [self getModelName:call result: result];
    else if ([@"getFirmwareVersion" isEqualToString:call.method])           return [self getFirmwareVersion:call result: result];
    else if ([@"getPrinterDPI" isEqualToString:call.method])                return [self getPrinterDPI:call result: result];
    else if ([@"getMaxWidth" isEqualToString:call.method])                  return [self getMaxWidth:call result: result];
    else if ([@"getSupportedSpeeds" isEqualToString:call.method])           return [self getSupportedSpeeds:call result: result];
    else if ([@"getStatisticsData" isEqualToString:call.method])            return [self getStatisticsData:call result: result];
    else if ([@"setupRFID" isEqualToString:call.method])                    return [self setupRFID:call result: result];
    else if ([@"calibrateRFID" isEqualToString:call.method])                return [self calibrateRFID:call result: result];
    else if ([@"setRFIDPosition" isEqualToString:call.method])              return [self setRFIDPosition:call result: result];
    else if ([@"setRFIDPassword" isEqualToString:call.method])              return [self setRFIDPassword:call result: result];
    else if ([@"setEPCDataStructure" isEqualToString:call.method])          return [self setEPCDataStructure:call result: result];
    else if ([@"writeRFID" isEqualToString:call.method])                    return [self writeRFID:call result: result];
    else if ([@"lockRFID" isEqualToString:call.method])                     return [self lockRFID:call result: result];
    else {
        result(FlutterMethodNotImplemented);
    }
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
    NSNumber* deviceId = (NSNumber*)[notification object];
    if ([[notification name] isEqualToString: @"StatusUpdateEvent"]){
        if([deviceId integerValue] != self.printer.getDeviceId)
            return;
        NSMutableArray *allKeys = [[[notification userInfo] allKeys] mutableCopy];
        for (NSString *key in allKeys) {
            NSInteger status = [[[notification userInfo] objectForKey: key] integerValue];
            if(self.eventSink != nil){
                self.eventSink([NSNumber numberWithInteger:status]);
            }else{
            }
        }
    }else if ([[notification name] isEqualToString: @"OutputCompletedEvent"]){
        
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

- (void)setCharacterset:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* characterset = arguments[@"character_set"] ? : @0;
    NSNumber* inter_characterset = arguments[@"international_character_set"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setCharacterset:[characterset integerValue]
                                        internationalCharset:[inter_characterset integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)checkPrinterStatus:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSInteger nativeResult = [self.printer checkPrinterStatus];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)printBuffer:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* copies = arguments[@"copies"] ? : @1;
    MPOS_RESULT nativeResult = [self.printer printBuffer:[copies integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawTextDeviceFont:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSString* font = arguments[@"font_type"] ? : @"";
    NSNumber* fontWidth = arguments[@"font_width"] ? : @1;
    NSNumber* fontHeight = arguments[@"font_height"] ? : @1;
    NSNumber* rightSpace = arguments[@"right_space"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;
    NSNumber* reverse = arguments[@"reverse"] ? : @0;
    NSNumber* bold = arguments[@"bold"] ? : @0;
    NSNumber* rightToLeft = arguments[@"right_to_left"] ? : @0;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer drawTextDeviceFont:data
                                                           xPos:[xPosition integerValue]
                                                           yPos:[yPosition integerValue]
                                                  fontSelection:(char)[font UTF8String][0]
                                                      fontWidth:[fontWidth integerValue]
                                                     fontHeight:[fontHeight integerValue]
                                                     rightSpace:[rightSpace integerValue]
                                                       rotation:[rotation integerValue]
                                                        reverse:([reverse integerValue] > 0)
                                                           bold:([bold integerValue] > 0)
                                                    rightToLeft:([rightToLeft integerValue] > 0)
                                                      alignment:[alignment integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawTextVectorFont:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSString* font = arguments[@"font_type"] ? : @"";
    NSNumber* fontWidth = arguments[@"font_width"] ? : @24;
    NSNumber* fontHeight = arguments[@"font_height"] ? : @24;
    NSNumber* rightSpace = arguments[@"right_space"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;
    NSNumber* reverse = arguments[@"reverse"] ? : @0;
    NSNumber* bold = arguments[@"bold"] ? : @0;
    NSNumber* italic = arguments[@"italic"] ? : @0;
    NSNumber* rightToLeft = arguments[@"right_to_left"] ? : @0;
    NSNumber* alignment = arguments[@"alignment"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawTextVectorFont:data
                                                           xPos:[xPosition integerValue]
                                                           yPos:[yPosition integerValue]
                                                  fontSelection:(char)[font UTF8String][0]
                                                      fontWidth:[fontWidth integerValue]
                                                     fontHeight:[fontHeight integerValue]
                                                     rightSpace:[rightSpace integerValue]
                                                       rotation:[rotation integerValue]
                                                        reverse:([reverse integerValue] > 0)
                                                           bold:([bold integerValue] > 0)
                                                         italic:([italic integerValue] > 0)
                                                    rightToLeft:([rightToLeft integerValue] > 0)
                                                      alignment:[alignment integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcode1D:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* barcode_type = arguments[@"barcode_type"] ? : @0;
    NSNumber* width_narrow = arguments[@"width_narrow"] ? : @1;
    NSNumber* width_wide = arguments[@"width_wide"] ? : @1;
    NSNumber* height = arguments[@"height"] ? : @0;
    NSNumber* hri = arguments[@"hri"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;
    NSNumber* quiet_zone_width = arguments[@"quiet_zone_width"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcode1D:data
                                                      xPos:[xPosition integerValue]
                                                      yPos:[yPosition integerValue]
                                               barcodeType:[barcode_type integerValue]
                                               widthNarrow:[width_narrow integerValue]
                                                 widthWide:[width_wide integerValue]
                                                    height:[height integerValue]
                                                       hri:[hri integerValue]
                                            quietZoneWidth:[quiet_zone_width integerValue]
                                                  rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeMaxiCode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* mode = arguments[@"mode"] ? : @4;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeMaxiCode:data
                                                            xPos:[xPosition integerValue]
                                                            yPos:[yPosition integerValue]
                                                            mode:[mode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodePDF417:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* maximum_row_count = arguments[@"maximum_row_count"] ? : @30;
    NSNumber* maximum_column_count = arguments[@"maximum_column_count"] ? : @5;
    NSNumber* ecc_level = arguments[@"ecc_level"] ? : @0;
    NSNumber* data_compression_method = arguments[@"data_compression_method"] ? : @0;
    NSNumber* hri = arguments[@"hri"] ? : @0;
    NSNumber* origin_point = arguments[@"origin_point"] ? : @0;
    NSNumber* module_width = arguments[@"module_width"] ? : @0;
    NSNumber* bar_height = arguments[@"bar_height"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodePDF417:data
                                                          xPos:[xPosition integerValue]
                                                          yPos:[yPosition integerValue]
                                               maximumRowCount:[maximum_row_count integerValue]
                                            maximumColumnCount:[maximum_column_count integerValue]
                                          errorCorrectionLevel:[ecc_level integerValue]
                                         dataCompressionMethod:[data_compression_method integerValue]
                                                           hri:[hri integerValue] > 0
                                                 startPosition:[origin_point integerValue]
                                                   moduleWidth:[module_width integerValue]
                                                     barHeight:[bar_height integerValue]
                                                      rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeQRCode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* size = arguments[@"size"] ? : @4;
    NSNumber* model = arguments[@"model"] ? : @2;
    NSNumber* ecc_level = arguments[@"ecc_level"] ? : @51;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeQRCode:data
                                                          xPos:[xPosition integerValue]
                                                          yPos:[yPosition integerValue]
                                                          size:[size integerValue]
                                                         model:[model integerValue]
                                                      eccLevel:[ecc_level integerValue]
                                                      rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeDataMatrix:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* size = arguments[@"size"] ? : @0;
    NSNumber* reverse = arguments[@"reverse"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeDataMatrix:data
                                                              xPos:[xPosition integerValue]
                                                              yPos:[yPosition integerValue]
                                                              size:[size integerValue]
                                                           reverse:[reverse integerValue] > 0
                                                          rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeAztec:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* size = arguments[@"size"] ? : @0;
    NSNumber* extended_channel = arguments[@"extended_channel"] ? : @0;
    NSNumber* eccLevel = arguments[@"ecc_level"] ? : @0;
    NSNumber* menu_symbol = arguments[@"menu_symbol"] ? : @0;
    NSNumber* number_of_symbols = arguments[@"number_of_symbols"] ? : @0;
    NSString* optional_id = arguments[@"optional_id"] ? : @"";
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeAztec:data
                                                         xPos:[xPosition integerValue]
                                                         yPos:[yPosition integerValue]
                                                         size:[size integerValue]
                                              extendedChannel:[extended_channel integerValue] > 0
                                                     eccLevel:[eccLevel integerValue]
                                                   menuSymbol:[menu_symbol integerValue] > 0
                                              numberOfSymbols:[number_of_symbols integerValue]
                                                   optionalID:optional_id
                                                     rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeCode49:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* width_narrow = arguments[@"width_narrow"] ? : @0;
    NSNumber* width_wide = arguments[@"width_wide"] ? : @0;
    NSNumber* height = arguments[@"height"] ? : @0;
    NSNumber* hri = arguments[@"hri"] ? : @0;
    NSNumber* starting_mode = arguments[@"starting_mode"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeCode49:data
                                                          xPos:[xPosition integerValue]
                                                          yPos:[yPosition integerValue]
                                                   widthNarrow:[width_narrow integerValue]
                                                     widthWide:[width_wide integerValue]
                                                        height:[height integerValue]
                                                           hri:[hri integerValue]
                                                  startingMode:[starting_mode integerValue]
                                                      rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeCodaBlock:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* width_narrow = arguments[@"width_narrow"] ? : @0;
    NSNumber* width_wide = arguments[@"width_wide"] ? : @0;
    NSNumber* height = arguments[@"height"] ? : @0;
    NSString* mode = arguments[@"mode"] ? : @"F";
    NSNumber* security_level = arguments[@"security_level"] ? : @0;
    NSNumber* data_columns = arguments[@"data_columns"] ? : @2;
    NSNumber* rowsToEncode = arguments[@"rows_to_encode"] ? : @2;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeCodaBlock:data
                                                             xPos:[xPosition integerValue]
                                                             yPos:[yPosition integerValue]
                                                      widthNarrow:[width_narrow integerValue]
                                                        widthWide:[width_wide integerValue]
                                                           height:[height integerValue]
                                                    securityLevel:[security_level integerValue] > 0
                                                      dataColumns:[data_columns integerValue]
                                                             mode:(char)[mode UTF8String][0]
                                                     rowsToEncode:[rowsToEncode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeMicroPDF:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* module_width = arguments[@"module_width"] ? : @4;
    NSNumber* height = arguments[@"height"] ? : @10;
    NSNumber* mode = arguments[@"mode"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeMicroPDF:data
                                                            xPos:[xPosition integerValue]
                                                            yPos:[yPosition integerValue]
                                                     moduleWidth:[module_width integerValue]
                                                          height:[height integerValue]
                                                            mode:[mode integerValue]
                                                        rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeIMB:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* hri = arguments[@"hri"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeIMB:data
                                                       xPos:[xPosition integerValue]
                                                       yPos:[yPosition integerValue]
                                                        hri:[hri integerValue] > 0
                                                   rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeMSI:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* width_narrow = arguments[@"width_narrow"] ? : @0;
    NSNumber* width_wide = arguments[@"width_wide"] ? : @0;
    NSNumber* height = arguments[@"height"] ? : @0;
    NSNumber* check_digit = arguments[@"check_digit"] ? : @0;
    NSNumber* print_check_digit = arguments[@"print_check_digit"] ? : @0;
    NSNumber* hri = arguments[@"hri"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeMSI:data
                                                       xPos:[xPosition integerValue]
                                                       yPos:[yPosition integerValue]
                                                widthNarrow:[width_narrow integerValue]
                                                  widthWide:[width_wide integerValue]
                                                     height:[height integerValue]
                                                 checkDigit:[check_digit integerValue]
                                            printCheckDigit:[print_check_digit integerValue] > 0
                                                        hri:[hri integerValue]
                                                   rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodePlessey:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* width_narrow = arguments[@"width_narrow"] ? : @0;
    NSNumber* width_wide = arguments[@"width_wide"] ? : @0;
    NSNumber* height = arguments[@"height"] ? : @0;
    NSNumber* print_check_digit = arguments[@"print_check_digit"] ? : @0;
    NSNumber* hri = arguments[@"hri"] ? : @0;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodePlessey:data
                                                           xPos:[xPosition integerValue]
                                                           yPos:[yPosition integerValue]
                                                    widthNarrow:[width_narrow integerValue]
                                                      widthWide:[width_wide integerValue]
                                                         height:[height integerValue]
                                                printCheckDigit:[print_check_digit integerValue] > 0
                                                            hri:[hri integerValue]
                                                       rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeTLC39:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* width_narrow = arguments[@"width_narrow"] ? : @0;
    NSNumber* width_wide = arguments[@"width_wide"] ? : @0;
    NSNumber* height = arguments[@"height"] ? : @0;
    NSNumber* row_height_of_micro_pdf417 = arguments[@"row_height_of_micro_pdf417"] ? : @10;
    NSNumber* narrow_width_of_micro_pdf417 = arguments[@"narrow_width_of_micro_pdf417"] ? : @5;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeTLC39:data
                                                         xPos:[xPosition integerValue]
                                                         yPos:[yPosition integerValue]
                                                  widthNarrow:[width_narrow integerValue]
                                                    widthWide:[width_wide integerValue]
                                                       height:[height integerValue]
                                       rowHeightOfMicroPDF417:[row_height_of_micro_pdf417 integerValue]
                                     narrowWidthOfMicroPDF417:[narrow_width_of_micro_pdf417 integerValue]
                                                     rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBarcodeRSS:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* barcode_type = arguments[@"barcode_type"] ? : @0;
    NSNumber* magnification = arguments[@"magnification"] ? : @1;
    NSNumber* separator_height = arguments[@"separator_height"] ? : @1;
    NSNumber* height = arguments[@"height"] ? : @0;
    NSNumber* segment_width = arguments[@"segment_width"] ? : @10;
    NSNumber* rotation = arguments[@"rotation"] ? : @0;

    MPOS_RESULT nativeResult = [self.printer drawBarcodeRSS:data
                                                       xPos:[xPosition integerValue]
                                                       yPos:[yPosition integerValue]
                                                barcodeType:[barcode_type integerValue]
                                              magnification:[magnification integerValue]
                                            separatorHeight:[separator_height integerValue]
                                                     height:[height integerValue]
                                               segmentWidth:[segment_width integerValue]
                                                   rotation:[rotation integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}


- (void)drawBlock:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* start_pos_x = arguments[@"start_pos_x"] ? : @0;
    NSNumber* start_pos_y = arguments[@"start_pos_y"] ? : @0;
    NSNumber* end_pos_x = arguments[@"end_pos_x"] ? : @0;
    NSNumber* end_pos_y = arguments[@"end_pos_y"] ? : @0;
    NSNumber* thickness = arguments[@"thickness"] ? : @0;
    NSString* option = arguments[@"option"] ? : @"B";
    
    MPOS_RESULT nativeResult = [self.printer drawBlock:[start_pos_x integerValue]
                                             startPosY:[start_pos_y integerValue]
                                               endPosX:[end_pos_x integerValue]
                                               endPosY:[end_pos_y integerValue]
                                                option:(char)[option UTF8String][0]
                                             thickness:[thickness integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}


- (void)drawCircle:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* start_pos_x = arguments[@"start_pos_x"] ? : @0;
    NSNumber* start_pos_y = arguments[@"start_pos_y"] ? : @0;
    NSNumber* size = arguments[@"size"] ? : @0;
    NSNumber* multiplier = arguments[@"multiplier"] ? : @0;
    
    MPOS_RESULT nativeResult = [self.printer drawCircle:[start_pos_x integerValue]
                                              startPosY:[start_pos_y integerValue]
                                                   size:[size integerValue]
                                             multiplier:[multiplier integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawBase64Image:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"];
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* width = arguments[@"width"] ? : @-1;
    NSNumber* threshold = arguments[@"threshold"] ? : @128;
    NSNumber* ditheringType = arguments[@"dithering_type"] ? : @1;
    NSNumber* compressType = arguments[@"compress_type"] ? : @1;
    MPOS_RESULT nativeResult = [self.printer drawBase64Image:data
                                                        xPos:[xPosition integerValue]
                                                        yPos:[yPosition integerValue]
                                                       width:[width integerValue]
                                                   threshold:[threshold integerValue]
                                               ditheringType:[ditheringType integerValue]
                                                compressType:[compressType integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)drawPDFFile:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* fileName = arguments[@"file_name"];
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* width = arguments[@"width"] ? : @-1;
    NSNumber* pageNumber = arguments[@"page_number"] ? : @0;
    NSNumber* threshold = arguments[@"threshold"] ? : @128;
    NSNumber* ditheringType = arguments[@"dithering_type"] ? : @1;
    NSNumber* compressType = arguments[@"compress_type"] ? : @1;
    MPOS_RESULT nativeResult = [self.printer drawPDFFile:fileName
                                                    posX:[xPosition integerValue]
                                                    posY:[yPosition integerValue]
                                                   width:[width integerValue]
                                              pageNumber:[pageNumber integerValue]
                                               threshold:[threshold integerValue]
                                           ditheringType:[ditheringType integerValue]
                                            compressType:[compressType integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}


- (void)drawImageFile:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* fileName = arguments[@"file_name"];
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    NSNumber* width = arguments[@"width"] ? : @-1;
    NSNumber* threshold = arguments[@"threshold"] ? : @128;
    NSNumber* ditheringType = arguments[@"dithering_type"] ? : @1;
    NSNumber* compressType = arguments[@"compress_type"] ? : @1;
    MPOS_RESULT nativeResult = [self.printer drawImageFile:fileName
                                                      xPos:[xPosition integerValue]
                                                      yPos:[yPosition integerValue]
                                                     width:[width integerValue]
                                                 threshold:[threshold integerValue]
                                             ditheringType:[ditheringType integerValue]
                                              compressType:[compressType integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setPrintingType:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* printing_type = arguments[@"printing_type"] ? : @"d";
    MPOS_RESULT nativeResult = [self.printer setPrintingType:(char)[printing_type UTF8String][0]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setMargin:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* horizontal_margin = arguments[@"horizontal_margin"] ? : @0;
    NSNumber* vertical_margin = arguments[@"vertical_margin"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setMargin:[horizontal_margin integerValue]
                                        verticalMargin:[vertical_margin integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setLength:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* label_length = arguments[@"label_length"] ? : @0;
    NSNumber* gap_length = arguments[@"gap_length"] ? : @0;
    NSString* media_type = arguments[@"media_type"] ? : @"G";
    NSNumber* offset_length = arguments[@"offset_length"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setLength:[label_length integerValue]
                                             gapLength:[gap_length integerValue]
                                             mediaType:(char)[media_type UTF8String][0]
                                          offsetLength:[offset_length integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setWidth:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* label_width = arguments[@"label_width"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setWidth:[label_width integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setSpeed:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* speed = arguments[@"speed"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setSpeed:[speed integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setDensity:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* density = arguments[@"density"] ? : @10;
    MPOS_RESULT nativeResult = [self.printer setDensity:[density integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setOrientation:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* orientation = arguments[@"orientation"] ? : @"T";
    MPOS_RESULT nativeResult = [self.printer setOrientation:(char)[orientation UTF8String][0]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setOffset:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* length = arguments[@"length"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setOffset:[length integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setCuttingPosition:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* length = arguments[@"length"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setCuttingPosition:[length integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setAutoCutter:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* enable_autocutter = arguments[@"enable_autocutter"] ? : @0;
    NSNumber* cut_period = arguments[@"cut_period"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setAutoCutter:([enable_autocutter integerValue] > 0)
                                             cuttingPeriod:[cut_period integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setRewinder:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* enable_rewinder = arguments[@"enable_rewinder"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setRewinder:[enable_rewinder integerValue] > 0];
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

- (void)getPrinterDPI:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSInteger nativeResult = [self.printer getPrinterDPI];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)getMaxWidth:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSInteger nativeResult = [self.printer getMaxWidth];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)getSupportedSpeeds:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSArray<NSNumber*>* speeds = [self.printer getSupportedSpeeds];
    result(speeds);
}

- (void)getStatisticsData:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* info = arguments[@"request_info"] ? : @0;
    NSString* nativeResult = [self.printer getStatisticsData:[info integerValue]];
    result(nativeResult);
}

- (void)setupRFID:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* rfid_type = arguments[@"rfid_type"] ? : @0;
    NSNumber* number_of_retries = arguments[@"number_of_retries"] ? : @0;
    NSNumber* number_of_labels = arguments[@"number_of_labels"] ? : @0;
    NSNumber* radio_power = arguments[@"radio_power"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setupRFID:[rfid_type integerValue]
                                       numberOfRetries:[number_of_retries integerValue]
                                         numberOfLabel:[number_of_labels integerValue]
                                            radioPower:[radio_power integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)calibrateRFID:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.printer calibrateRFID];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setRFIDPosition:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* trans_position = arguments[@"trans_position"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer setRFIDPosition:[trans_position integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setRFIDPassword:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* old_access_pwd = arguments[@"old_access_pwd"] ? : @"";
    NSString* old_kill_pwd = arguments[@"old_kill_pwd"] ? : @"";
    NSString* new_access_pwd = arguments[@"new_access_pwd"] ? : @"";
    NSString* new_kill_pwd = arguments[@"new_kill_pwd"] ? : @"";
    MPOS_RESULT nativeResult = [self.printer setRFIDPassword:old_access_pwd
                                                  oldKillPwd:old_kill_pwd
                                                newAccessPwd:new_access_pwd
                                                  newKillPwd:new_kill_pwd];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setEPCDataStructure:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* total_size = arguments[@"total_size"] ? : @0;
    NSString* field_sizes = arguments[@"field_sizes"] ? : @"";
    MPOS_RESULT nativeResult = [self.printer setEPCDataStructure:[total_size integerValue]
                                                      fieldSizes:field_sizes];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)writeRFID:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* data_type = arguments[@"data_type"] ? : @0;
    NSNumber* start_block_number = arguments[@"start_block_number"] ? : @0;
    NSNumber* data_length = arguments[@"data_length"] ? : @0;
    MPOS_RESULT nativeResult = [self.printer writeRFID:[data_type integerValue]
                                   startingBlockNumber:[start_block_number integerValue]
                                            dataLength:[data_length integerValue]
                                                  data:data];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)lockRFID:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.printer lockRFID];
    result([NSNumber numberWithInteger:nativeResult]);
}


- (NSString*) convertJSONString:(NSArray<NSNumber*>*) resData {
    if(![resData count]){
        return @"[]";
    }
    NSString* dataInJSON = @"";
    int index = 0;
    dataInJSON = [dataInJSON stringByAppendingString: @"[{"];
    for (NSNumber* speed in resData) {
        NSString* keyWithValue = [NSString stringWithFormat:@"\"%d\":%ld,", index, (long)[speed integerValue]];
        dataInJSON = [dataInJSON stringByAppendingString: keyWithValue];
        index++;
    }
    dataInJSON = [dataInJSON substringToIndex:[dataInJSON length]-1];
    dataInJSON = [dataInJSON stringByAppendingString: @"}]"];
    return dataInJSON;
}


@end

