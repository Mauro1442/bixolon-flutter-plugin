@import frameworkMPosSDK;

#import "BxlflutterbgatelibPlugin.h"
#import "BxlMPosLibVersionPlugin.h"
#import "BxlMPosControllerPrinterPlugin.h"
#import "BxlMPosControllerLabelPrinterPlugin.h"
#import "BxlMPosControllerConfigPlugin.h"
#import "BxlMPosLookupPlugin.h"

@implementation BxlflutterbgatelibPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [BxlMPosLibVersionPlugin registerWithRegistrar:registrar];
    [BxlMPosLookupPlugin registerWithRegistrar:registrar];
    [BxlMPosControllerPrinterPlugin registerWithRegistrar:registrar];
    [BxlMPosControllerLabelPrinterPlugin registerWithRegistrar:registrar];
    [BxlMPosControllerConfigPlugin registerWithRegistrar:registrar];
}

@end
