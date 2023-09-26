
#import <Foundation/Foundation.h>
#import "MPosResults.h"
#import "MPosDefines.h"
#import "MPosDeviceInfo.h"

@interface MPosLookup : NSObject
#pragma mark - deprecated
- (MPOS_RESULT) refreshDeviceList:(NSInteger)intefaceType
__deprecated;
- (NSArray<MPosDeviceInfo*>*) getDeviceList:(NSInteger)intefaceType
__deprecated;
- (MPOS_RESULT)refreshBluetoothDevicesList:(NSString*) protocolString
__deprecated;
- (NSArray<MPosDeviceInfo*>*) getBluetoothDevicesList
__deprecated;
@end

@interface MPosLookup (V2)
- (NSArray<MPosDeviceInfo*>*) getNetworkDevices;
- (NSArray<MPosDeviceInfo*>*) getBluetoothDevices;
- (NSArray<MPosDeviceInfo*>*) getBLEDevices;
- (MPOS_RESULT) discoverNetworkDevices;
- (MPOS_RESULT) discoverBLEDevices;
@end
