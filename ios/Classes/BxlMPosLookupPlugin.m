#import "BxlMPosLookupPlugin.h"
//#import "MPosLookup.h"
//#import "MPosDeviceInfo.h"
//#import "MPosResults.h"
//#import "MPosDefines.h"
//#import "MPosControllerDevices.h"
@import frameworkMPosSDK;

static NSString* const PLATFORM_CHANNEL = @"com.bixolon.mposlookup";

@interface BxlMPosLookupPlugin()
@property MPosLookup* lookup;
@end

@implementation BxlMPosLookupPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName: PLATFORM_CHANNEL
                                     binaryMessenger:[registrar messenger]];
    
    BxlMPosLookupPlugin* instance = [[BxlMPosLookupPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (id)init{
    [MPosControllerDevices setEnableLog:YES saveFile:NO saveToHex:NO];
    if((self=[super init])){
        self.lookup = [MPosLookup new];
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getBluetoothDevices" isEqualToString:call.method])       return [self getBluetoothDevices:call result: result];
    else if ([@"getBLEDevices" isEqualToString:call.method])        return [self getBLEDevices:call result: result];
    else if ([@"getNetworkDevices" isEqualToString:call.method])    return [self getNetworkDevices:call result: result];
    else if ([@"getUSBDevices" isEqualToString:call.method])        return [self getUSBDevices:call result: result];
    else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)getBluetoothDevices:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSArray<MPosDeviceInfo*>* list = [self.lookup getBluetoothDevices];
    NSString* jsonString = [self convertJSONString:list];
    result(jsonString);
}

- (void)getBLEDevices:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSArray<MPosDeviceInfo*>* list = [self.lookup getBLEDevices];
    NSString* jsonString = [self convertJSONString:list];
    result(jsonString);
}

- (void)getNetworkDevices:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSArray<MPosDeviceInfo*>* list = [self.lookup getNetworkDevices];
    NSString* jsonString = [self convertJSONString:list];
    result(jsonString);
}

- (void)getUSBDevices:(FlutterMethodCall*)call result:(FlutterResult)result {
    result(@"[]");
}


- (NSString*) convertJSONString:(NSArray<MPosDeviceInfo*>*) list  {
    
    if(![list count]){
        return @"[]";
    }
    
    NSMutableArray* jsonArray = [NSMutableArray array];
    for (MPosDeviceInfo* item in list) {
        NSMutableDictionary* jsonItem = [NSMutableDictionary dictionary];
        jsonItem[@"interface_type"] = [NSNumber numberWithInt:(int)item.interfaceType];
        if(![item.name length]){
            item.name = @"";
            switch (item.interfaceType) {
                case MPOS_INTERFACE_WIFI:
                case MPOS_INTERFACE_ETHERNET:
                    jsonItem[@"device_name"] = @"NETWORK DEVICE";
                    break;
                default:
                    jsonItem[@"device_name"] = item.address;
                    break;
            }
        }else{
            jsonItem[@"device_name"] = item.name;
        }
        
        switch (item.interfaceType) {
            case MPOS_INTERFACE_WIFI:
            case MPOS_INTERFACE_ETHERNET:
                jsonItem[@"address"] = [NSString stringWithFormat:@"%@:%@",item.address,[item.portNumber stringValue]];
                break;
            case MPOS_INTERFACE_BLE:
            case MPOS_INTERFACE_BLUETOOTH:
                jsonItem[@"address"] = item.macAddress;
                break;
        }
        [jsonArray addObject:jsonItem];
    }
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@",jsonString];
}

@end
