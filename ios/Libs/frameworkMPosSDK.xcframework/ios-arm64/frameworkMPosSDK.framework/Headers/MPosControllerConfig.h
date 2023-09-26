
#import "MPosControllerDevices.h"

@interface MPosControllerConfig : MPosControllerDevices

- (NSArray<NSNumber*>*) searchDevices;
- (NSString*) getBgateSerialNumber;
- (NSString*) getUSBDevice:(NSInteger)deviceId;
- (NSArray<NSString*>*) getCustomDevices:(MPOS_DEVICE_TYPE)deviceType;
- (NSArray<NSNumber*>*) getSerialConfiguration:(NSInteger)deviceId;
- (NSArray<NSNumber*>*) getSerialConfig:(NSInteger)deviceId;

- (MPOS_RESULT) searchDevices:(void(^)(NSArray<NSNumber*>*)) deviceIdBlock;
- (MPOS_RESULT) reInitCustomDeviceType:(MPOS_DEVICE_TYPE)deviceType;
- (MPOS_RESULT) addCustomDevice:(MPOS_DEVICE_TYPE)deviceType vid:(NSString*)vid pid:(NSString*)pid;
- (MPOS_RESULT) deleteCustomDevice:(MPOS_DEVICE_TYPE)deviceType vid:(NSString*)vid pid:(NSString*)pid;
- (MPOS_RESULT) getCustomDevices:(MPOS_DEVICE_TYPE)deviceType vidPidListBlock:(void(^)(NSArray<NSString*>*)) vidPidListBlock;
- (MPOS_RESULT) getUSBDevice: (NSInteger)deviceId vidPidBlock:(void(^)(NSString*)) vidPidBlock;
- (MPOS_RESULT) getBgateSerialNumber: (void(^)(NSString*)) serialNumberBlock;
- (MPOS_RESULT) getSerialConfiguration:(NSInteger)deviceId serialConfigBlock:(void(^)(NSArray<NSNumber*>*)) serialConfigBlock;
- (MPOS_RESULT) setSerialConfiguration:(NSInteger)deviceId
                              baudRate:(NSInteger)baudRate
                               dataBit:(NSInteger)dataBit
                               stopBit:(NSInteger)stopBit
                             parityBit:(NSInteger)parityBit
                           flowControl:(NSInteger)flowControl;

- (MPOS_RESULT) setSerialConfig:(NSInteger)deviceId
                       baudRate:(NSInteger)baudRate
                        dataBit:(NSInteger)dataBit
                        stopBit:(NSInteger)stopBit
                      parityBit:(NSInteger)parityBit;

@end
