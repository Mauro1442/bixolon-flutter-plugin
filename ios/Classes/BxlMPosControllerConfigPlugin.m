#import "BxlMPosControllerConfigPlugin.h"
//#import "MPosControllerConfig.h"
//#import "MPosDeviceInfo.h"
//#import "MPosResults.h"
//#import "MPosDefines.h"
@import frameworkMPosSDK;

static NSString* const PLATFORM_CHANNEL = @"com.bixolon.mposcontroller/config";

@interface BxlMPosControllerConfigPlugin()
@property MPosControllerConfig* config;
@end

@implementation BxlMPosControllerConfigPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName: PLATFORM_CHANNEL
                                     binaryMessenger:[registrar messenger]];
    
    BxlMPosControllerConfigPlugin* instance = [[BxlMPosControllerConfigPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (NSInteger)getDeviceID {
    return [self.config getDeviceId];
}

- (id)init{
    [MPosControllerDevices setEnableLog:YES saveFile:NO saveToHex:NO];
    if((self=[super init])){
        self.config = [MPosControllerConfig new];
    }
    return self;
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
    // Config API
    else if ([@"searchDevices" isEqualToString:call.method])                return [self searchDevices:call result: result];
    else if ([@"getBgateSerialNumber" isEqualToString:call.method])         return [self getBgateSerialNumber:call result: result];
    else if ([@"getUSBDevice" isEqualToString:call.method])                 return [self getUSBDevice:call result: result];
    else if ([@"getCustomDevices" isEqualToString:call.method])             return [self getCustomDevices:call result: result];
    else if ([@"getSerialConfig" isEqualToString:call.method])              return [self getSerialConfig:call result: result];
    else if ([@"getSerialConfiguration" isEqualToString:call.method])       return [self getSerialConfiguration:call result: result];
    else if ([@"setSerialConfig" isEqualToString:call.method])              return [self setSerialConfig:call result: result];
    else if ([@"setSerialConfiguration" isEqualToString:call.method])       return [self setSerialConfiguration:call result: result];
    else if ([@"addCustomDevice" isEqualToString:call.method])              return [self addCustomDevice:call result: result];
    else if ([@"deleteCustomDevice" isEqualToString:call.method])           return [self deleteCustomDevice:call result: result];
    else if ([@"reInitCustomDeviceType" isEqualToString:call.method])       return [self reInitCustomDeviceType:call result: result];
    else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)openService:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* deviceId = arguments[@"device_id"] ? : @-1;
    NSNumber* timeout = arguments[@"time_out"] ? : @3;
    MPOS_RESULT nativeResult = [self.config openService:[deviceId integerValue] timeout:[timeout integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)closeService:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* timeout = arguments[@"time_out"] ? : @3;
    MPOS_RESULT nativeResult = [self.config closeService:[timeout integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)selectInterface:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* interfaceType = arguments[@"interface_type"] ? : @-1;
    NSString* address = arguments[@"address"] ? : @3;
    MPOS_RESULT nativeResult = [self.config selectInterface:[interfaceType integerValue] address:address];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)selectCommandMode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* commandMode = arguments[@"command_mode"] ? : @-1;
    MPOS_RESULT nativeResult = [self.config selectCommandMode:[commandMode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setTransaction:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* transaction = arguments[@"transaction"] ? : @-1;
    MPOS_RESULT nativeResult = [self.config setTransaction:[transaction integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setReadMode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* mode = arguments[@"read_mode"] ? : @-1;
    MPOS_RESULT nativeResult = [self.config setReadMode:[mode integerValue]];
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
    MPOS_RESULT nativeResult = [self.config directIO:dataToSend];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)isOpen:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.config isOpen] ? 1 : 0;
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setKeepNetworkConnection:(FlutterMethodCall*)call result:(FlutterResult)result {
    if(![self.config isOpen]){
        NSDictionary* arguments = [call arguments];
        NSNumber* keep_connection = arguments[@"keep_connection"] ? : @0;
        [self.config setKeepNetworkConnection:[keep_connection integerValue]];
        result([NSNumber numberWithInteger: 0]);
    }else{
        result([NSNumber numberWithInteger: 1000]);
    }
}

- (void)searchDevices:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSArray<NSNumber*>* list = [self.config searchDevices];
    result([self convertJSONString: list]);
}

- (void)getBgateSerialNumber:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* resultString = [self.config getBgateSerialNumber];
    result(resultString);
}

- (void)getUSBDevice:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* deviceId = arguments[@"device_id"] ? : @-1;
    NSString* resultString = [self.config getUSBDevice:[deviceId integerValue]];
    result(resultString);
}

- (void)getCustomDevices:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* device_type = arguments[@"device_type"] ? : @-1;
    NSArray<NSString*>* list = [self.config getCustomDevices:[device_type integerValue]];
    result(list);
}

- (void)getSerialConfig:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* device_id = arguments[@"device_id"] ? : @-1;
    NSArray<NSNumber*>* configInfo = [self.config getSerialConfig:[device_id integerValue]];
    result(configInfo);
}

- (void)getSerialConfiguration:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* device_id = arguments[@"device_id"] ? : @-1;
    NSArray<NSNumber*>* configInfo = [self.config getSerialConfiguration:[device_id integerValue]];
    result(configInfo);
}

- (void)setSerialConfig:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* device_id = arguments[@"device_id"] ? : @-1;
    NSNumber* baud_rate = arguments[@"baud_rate"] ? : @-1;
    NSNumber* data_bit = arguments[@"data_bit"] ? : @-1;
    NSNumber* stop_bit = arguments[@"stop_bit"] ? : @-1;
    NSNumber* parity_bit = arguments[@"parity_bit"] ? : @-1;
    
    MPOS_RESULT nativeResult = [self.config setSerialConfig:[device_id integerValue]
                                                   baudRate:[baud_rate integerValue]
                                                    dataBit:[data_bit integerValue]
                                                    stopBit:[stop_bit integerValue]
                                                  parityBit:[parity_bit integerValue]];
    
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setSerialConfiguration:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* device_id = arguments[@"device_id"] ? : @-1;
    NSNumber* baud_rate = arguments[@"baud_rate"] ? : @2;
    NSNumber* data_bit = arguments[@"data_bit"] ? : @1;
    NSNumber* stop_bit = arguments[@"stop_bit"] ? : @0;
    NSNumber* parity_bit = arguments[@"parity_bit"] ? : @0;
    NSNumber* flow_control = arguments[@"flow_control"] ? : @0;
    
    MPOS_RESULT nativeResult = [self.config setSerialConfiguration:[device_id integerValue]
                                                          baudRate:[baud_rate integerValue]
                                                           dataBit:[data_bit integerValue]
                                                           stopBit:[stop_bit integerValue]
                                                         parityBit:[parity_bit integerValue]
                                                       flowControl:[flow_control integerValue]];
    
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)addCustomDevice:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* device_type = arguments[@"device_type"] ? : @-1;
    NSString* vid = arguments[@"vid"] ? : @"";
    NSString* pid = arguments[@"pid"] ? : @"";
    MPOS_RESULT nativeResult = [self.config addCustomDevice:[device_type integerValue] vid:vid pid:pid];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)deleteCustomDevice:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* device_type = arguments[@"device_type"] ? : @-1;
    NSString* vid = arguments[@"vid"] ? : @"";
    NSString* pid = arguments[@"pid"] ? : @"";
    MPOS_RESULT nativeResult = [self.config deleteCustomDevice:[device_type integerValue] vid:vid pid:pid];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)reInitCustomDeviceType:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* device_type = arguments[@"device_type"] ? : @-1;
    MPOS_RESULT nativeResult = [self.config reInitCustomDeviceType:[device_type integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (NSString*) convertJSONString:(NSArray<NSNumber*>*) list  {
    
    if(![list count]){
        return @"[]";
    }
    
    NSMutableArray* jsonArray = [NSMutableArray array];
    for (NSNumber* deviceid in list) {
        NSMutableDictionary* jsonItem = [NSMutableDictionary dictionary];
        jsonItem[@"device_id"] = deviceid;
        if([deviceid integerValue] > 0 && [deviceid integerValue] < 10){
            jsonItem[@"device_type"] = @"LABEL PRINTER";
        }else if([deviceid integerValue] >= 10 && [deviceid integerValue] < 20){
            jsonItem[@"device_type"] = @"POS PRINTER";
        }else if([deviceid integerValue] >= 20 && [deviceid integerValue] < 30){
            jsonItem[@"device_type"] = @"Unregistered HID INPUT DEVICE";
        }else if([deviceid integerValue] >= 30 && [deviceid integerValue] < 40){
            jsonItem[@"device_type"] = @"MSR";
        }else if([deviceid integerValue] >= 40 && [deviceid integerValue] < 50){
            jsonItem[@"device_type"] = @"BARCODE SCANNER";
        }else if([deviceid integerValue] >= 60 && [deviceid integerValue] < 70){
            jsonItem[@"device_type"] = @"RFID";
        }else if([deviceid integerValue] >= 70 && [deviceid integerValue] < 80){
            jsonItem[@"device_type"] = @"DALLAS READER";
        }else if([deviceid integerValue] >= 80 && [deviceid integerValue] < 90){
            jsonItem[@"device_type"] = @"NFC";
        }else if([deviceid integerValue] >= 100 && [deviceid integerValue] < 110){
            jsonItem[@"device_type"] = @"Unregistered USB-SERIAL";
        }else if([deviceid integerValue] >= 110 && [deviceid integerValue] < 120){
            jsonItem[@"device_type"] = @"CUSTOMER DISPLAY";
        }else if([deviceid integerValue] >= 120 && [deviceid integerValue] < 130){
            jsonItem[@"device_type"] = @"USB-SERIAL";
        }else if([deviceid integerValue] >= 130 && [deviceid integerValue] < 140){
            jsonItem[@"device_type"] = @"USB-SCALE";
        }else{
            jsonItem[@"device_type"] = @"UNKNOWN";
        }
        [jsonArray addObject:jsonItem];
    }
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@",jsonString];
}


@end
