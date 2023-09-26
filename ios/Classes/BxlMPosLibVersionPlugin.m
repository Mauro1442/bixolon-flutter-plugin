#import "BxlMPosLibVersionPlugin.h"
//#import "MPosLibVersion.h"
@import frameworkMPosSDK;

static NSString* const PLATFORM_CHANNEL = @"com.bixolon.mposlibversion";

@implementation BxlMPosLibVersionPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName: PLATFORM_CHANNEL
                                     binaryMessenger:[registrar messenger]];
    
    BxlMPosLibVersionPlugin* instance = [[BxlMPosLibVersionPlugin alloc] init];
    
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    //NSDictionary* arguments = [call arguments];
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([MPosLibVersion getVersionInfo]);
        //result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
