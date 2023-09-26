#import "MPosControllerDevices.h"
#import <UIKit/UIKit.h>

@interface MPosControllerBCD : MPosControllerDevices

- (MPOS_RESULT) setTextEncoding:(NSInteger)textEncoding;
- (MPOS_RESULT) setCharacterset:(NSInteger)characterset;
- (MPOS_RESULT) setInternationalCharacterset:(NSInteger)characterset;

- (MPOS_RESULT) storeImage:(UIImage*)data
                     width:(NSInteger)width
               imageNumber:(NSInteger)imageNumber
NS_SWIFT_NAME(storeImage(_:width:imageNumber:));

- (MPOS_RESULT) storeImageFile:(NSString*)fileName
                         width:(NSInteger)width
                   imageNumber:(NSInteger)imageNumber
NS_SWIFT_NAME(storeImageFile(_:width:imageNumber:));

- (MPOS_RESULT) storeBase64Image:(NSString*)base64String
                           width:(NSInteger)width
                     imageNumber:(NSInteger)imageNumber
NS_SWIFT_NAME(storeBase64Image(_:width:imageNumber:));


- (MPOS_RESULT) displayString:(NSString*)data;
- (MPOS_RESULT) displayString:(NSString*)data line:(NSInteger)line;
- (MPOS_RESULT) displayImage:(NSInteger)imageNumber xPos:(NSInteger)xPos yPos:(NSInteger)yPos;
- (MPOS_RESULT) clearImage:(BOOL)isAll imageNumber:(NSInteger)imageNumber;
- (MPOS_RESULT) clearScreen;

@end

@interface MPosControllerBCD (BCD)

- (MPOS_RESULT) displayString:(NSString*)data
                     codePage:(NSInteger)codePage
    internationalCharacterSet:(NSInteger)internationalCharacterSet
                         line:(NSInteger)line
NS_SWIFT_NAME(displayString(_:codePage:internationalCharacterSet:line:));
- (MPOS_RESULT) clearIamge:(NSInteger)imageNumber;
- (MPOS_RESULT) showCursor:(NSInteger)cursor;

@end
