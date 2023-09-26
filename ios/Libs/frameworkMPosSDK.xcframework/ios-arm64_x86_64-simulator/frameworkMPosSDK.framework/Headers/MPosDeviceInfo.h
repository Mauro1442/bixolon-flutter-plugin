

#ifndef MPosDeviceInfo_h
#define MPosDeviceInfo_h

#import <Foundation/Foundation.h>
#import "MPosResults.h"
#import "MPosDefines.h"

@interface MPosDeviceInfo : NSObject
@property (atomic) MPOS_INTERACE_TYPE interfaceType;
@property (retain) NSString* address;
@property (retain) NSNumber* portNumber;
@property (retain) NSString* macAddress;
@property (retain) NSString* name;
@property (retain) NSString* serialNumber;
@property (retain) NSString* hardwareRevision;
@property (retain) NSString* firmwareRevision;
@end


#endif /* MPosDeviceInfo_h */
