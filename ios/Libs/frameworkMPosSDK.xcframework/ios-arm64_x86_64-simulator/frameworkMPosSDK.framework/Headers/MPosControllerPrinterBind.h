#import <UIKit/UIKit.h>
#import "MPosControllerPrinter.h"
#import "MPosDefines.h"


@interface MPosControllerPrinterBind : MPosControllerPrinter

- (MPOS_RESULT) printBitmap:(UIImage*)imgObj
                      width:(NSInteger)width
                  alignment:(NSInteger)alignment
                 brightness:(NSInteger)brightness
                isDithering:(NSInteger)isDithering
                 isCompress:(NSInteger)isCompress;

- (MPOS_RESULT) printBitmapFile:(NSString*)filePath
                          width:(NSInteger)width
                      alignment:(NSInteger)alignment
                     brightness:(NSInteger)brightness
                    isDithering:(NSInteger)isDithering
                     isCompress:(NSInteger)isCompress;

- (MPOS_RESULT) printBitmapWithBase64:(NSString*)base64String
                                width:(NSInteger)width
                            alignment:(NSInteger)alignment
                           brightness:(NSInteger)brightness
                          isDithering:(NSInteger)isDithering
                           isCompress:(NSInteger)isCompress;

- (MPOS_RESULT) printPdfFile:(NSString*)filePath
                   startPage:(NSInteger)startPage
                     endPage:(NSInteger)endPage
                       width:(NSInteger)width
                   alignment:(NSInteger)alignment
                  brightness:(NSInteger)brightness
                 isDithering:(NSInteger)isDithering
                  isCompress:(NSInteger)isCompress;

@end

