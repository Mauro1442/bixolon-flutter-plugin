#import <UIKit/UIKit.h>
#import "MPosControllerDevices.h"
#import "MPosDefines.h"


@interface MPosControllerPrinter : MPosControllerDevices

- (MPOS_RESULT) setPagemode:(NSInteger)mode;

- (MPOS_RESULT) setPagemodePrintArea:(NSInteger)x
                                   y:(NSInteger)y
                               width:(NSInteger)width
                              height:(NSInteger)height;

- (MPOS_RESULT) setPagemodeDirection:(NSInteger)direction;
- (MPOS_RESULT) setPagemodePosition:(NSInteger)x y:(NSInteger)y;
- (MPOS_RESULT) setTextEncoding:(NSInteger)textEncoding;
- (MPOS_RESULT) setCharacterset:(NSInteger)characterset;
- (MPOS_RESULT) setInternationalCharacterset:(NSInteger)characterset;

- (MPOS_RESULT) printText:(NSString*)string;
- (MPOS_RESULT) printText:(NSString*)string fontAttributes:(MPOS_FONT_ATTRIBUTES)fontAttributes;
- (MPOS_RESULT) cutPaper;
- (MPOS_RESULT) cutPaper:(NSInteger)cutType;
- (MPOS_RESULT) openDrawer:(NSInteger)pinNumber;
- (MPOS_RESULT) asbEnable:(BOOL)enable;
- (NSInteger) checkPrinterStatus
NS_SWIFT_NAME(checkPrinterStatus());
- (MPOS_RESULT) checkPrinterStatus:(void(^)(NSInteger))statusBlock;
- (MPOS_RESULT) checkBattStatus:(void(^)(NSInteger))statusBlock;
- (MPOS_RESULT) getModelName: (void(^)(NSString*))modelNameBlock;
- (MPOS_RESULT) getFirmwareVersion: (void(^)(NSString*))firmwareVersionBlock;

- (MPOS_RESULT) getPrintBufferSize:(void(^)(NSInteger))bufferSizeBlock;
- (MPOS_RESULT) clearPrintBuffer:(void(^)(NSInteger))bufferClearResultBlock;


- (MPOS_RESULT) printQRCode:(NSString*)data
                      model:(NSInteger)model
                  alignment:(NSInteger)alignment
                 moduleSize:(NSInteger)moduleSize
                   eccLevel:(NSInteger)eccLevel;

- (MPOS_RESULT) printPDF417:(NSString*)data
                     symbol:(NSInteger)symbol
                  alignment:(NSInteger)alignment
               columnNumber:(NSInteger)columnNumber
                  rowNumber:(NSInteger)rowNumber
                moduleWidth:(NSInteger)moduleWidth
               moduleHeight:(NSInteger)moduleHeight
                   eccLevel:(NSInteger)eccLevel;

- (MPOS_RESULT) printGS1Databar:(NSString*)data
                         symbol:(NSInteger)symbol
                      alignment:(NSInteger)alignment
                     moduleSize:(NSInteger)moduleSize;

- (MPOS_RESULT) printDataMatrix:(NSString*)data
                      alignment:(NSInteger)alignment
                     moduleSize:(NSInteger)moduleSize;

- (MPOS_RESULT) print1DBarcode:(NSString*)data
                     symbology:(NSInteger)symbology
                         width:(NSInteger)width
                        height:(NSInteger)height
                     alignment:(NSInteger)alignment
                   textPostion:(NSInteger)textPosition;

- (MPOS_RESULT) printBitmap:(UIImage*)imgObj
                      width:(NSInteger)width
                  alignment:(NSInteger)alignment
                 brightness:(NSInteger)brightness
                isDithering:(BOOL)isDithering
                 isCompress:(BOOL)isCompress;

- (MPOS_RESULT) printBitmapFile:(NSString*)filePath
                          width:(NSInteger)width
                      alignment:(NSInteger)alignment
                     brightness:(NSInteger)brightness
                    isDithering:(BOOL)isDithering
                     isCompress:(BOOL)isCompress;

- (MPOS_RESULT) printBitmapWithBase64:(NSString*)base64String
                                width:(NSInteger)width
                            alignment:(NSInteger)alignment
                           brightness:(NSInteger)brightness
                          isDithering:(BOOL)isDithering
                           isCompress:(BOOL)isCompress;

- (MPOS_RESULT) printPdfFile:(NSString*)filePath
                   startPage:(NSInteger)startPage
                     endPage:(NSInteger)endPage
                       width:(NSInteger)width
                   alignment:(NSInteger)alignment
                  brightness:(NSInteger)brightness
                 isDithering:(BOOL)isDithering
                  isCompress:(BOOL)isCompress;

- (MPOS_RESULT) printLine:(NSInteger)x1
                       y1:(NSInteger)y1
                       x2:(NSInteger)x2
                       y2:(NSInteger)y2
                thickness:(NSInteger)thickness;

- (MPOS_RESULT) printBox:(NSInteger)x1
                      y1:(NSInteger)y1
                      x2:(NSInteger)x2
                      y2:(NSInteger)y2
               thickness:(NSInteger)thickness;

- (MPOS_RESULT) printImage:(UIImage*)image
                     width:(NSInteger)width
                 alignment:(NSInteger)alignment
                 threshold:(NSInteger)threshold
             ditheringType:(NSInteger)ditheringType
              compressType:(NSInteger)compressType
NS_SWIFT_NAME(printImage(_:width:alignment:threshold:ditheringType:compressType:));

- (MPOS_RESULT) printImageFile:(NSString*)filename
                         width:(NSInteger)width
                     alignment:(NSInteger)alignment
                     threshold:(NSInteger)threshold
                 ditheringType:(NSInteger)ditheringType
                  compressType:(NSInteger)compressType
NS_SWIFT_NAME(printImageFile(_:width:alignment:threshold:ditheringType:compressType:));

- (MPOS_RESULT) printBase64Image:(NSString*)base64String
                           width:(NSInteger)width
                       alignment:(NSInteger)alignment
                       threshold:(NSInteger)threshold
                   ditheringType:(NSInteger)ditheringType
                    compressType:(NSInteger)compressType
NS_SWIFT_NAME(printBase64Image(_:width:alignment:threshold:ditheringType:compressType:));

- (MPOS_RESULT) printPDFFile:(NSString*)filename
                       width:(NSInteger)width
                   alignment:(NSInteger)alignment
                   startPage:(NSInteger)startPage
                     endPage:(NSInteger)endPage
                   threshold:(NSInteger)threshold
               ditheringType:(NSInteger)ditheringType
                compressType:(NSInteger)compressType;
@end


@interface MPosControllerPrinter (PRINTER)

- (MPOS_RESULT) printText:(NSString*)data
                 fontType:(NSInteger)fontType
                fontWidth:(NSInteger)fontWidth
               fontHeight:(NSInteger)fontHeight
                     bold:(NSInteger)bold
                underline:(NSInteger)underline
                  reverse:(NSInteger)reverse
                alignment:(NSInteger)alignment;

- (MPOS_RESULT) printMaxicode:(NSString*)data
                         mode:(NSInteger)mode
                    alignment:(NSInteger)alignment;

- (MPOS_RESULT) printGS1DatabarMobile:(NSString*)data
                                cData:(NSString*)cData
                               symbol:(NSInteger)symbol
                            alignment:(NSInteger)alignment
                          moduleWidth:(NSInteger)moduleWidth
                         moduleHeight:(NSInteger)moduleHeight
                        segmentHeight:(NSInteger)segmentHeight
                      separatorHeight:(NSInteger)separatorHeight;

- (MPOS_RESULT) printCompositeSymbology:(NSString*)data
                                  cData:(NSString*)cData
                                 symbol:(NSInteger)symbol
                                cSymbol:(NSInteger)cSymbol
                              alignment:(NSInteger)alignment
                                   size:(NSInteger)size;

- (MPOS_RESULT) printAztec:(NSString*)data
                 alignment:(NSInteger)alignment
                moduleSize:(NSInteger)moduleSize
                  eccLevel:(NSInteger)eccLevel
                      mode:(NSInteger)mode;

- (MPOS_RESULT) openDrawer:(NSInteger)pinNumber
               onTimePulse:(NSInteger)onTimePulse
              offTimePulse:(NSInteger)offTimePulse;

- (NSString*) getModelName;
- (NSString*) getFirmwareVersion;
- (NSString*) getStatisticsData:(NSInteger)info;

@end

@interface MPosControllerPrinter (BCD)

- (MPOS_RESULT) displayString:(NSString*)data
                     codePage:(NSInteger)codePage
    internationalCharacterSet:(NSInteger)internationalCharacterSet
                         line:(NSInteger)line
NS_SWIFT_NAME(displayString(_:codePage:internationalCharacterSet:line:));

- (MPOS_RESULT) displayIamge:(NSInteger)imageNumber
                        xPos:(NSInteger)xPos
                        yPos:(NSInteger)yPos
NS_SWIFT_NAME(displayIamge(_:xPos:yPos:));

- (MPOS_RESULT) storeImage:(UIImage*)data
                     width:(NSInteger)width
               imageNumber:(NSInteger)imageNumber
NS_SWIFT_NAME(storeImage(_:width:imageNumber:));

- (MPOS_RESULT) storeImageFile:(NSString*)fileName
                         width:(NSInteger)width
                   imageNumber:(NSInteger)imageNumber
NS_SWIFT_NAME(storeImageFile(_:width:imageNumber:));

- (MPOS_RESULT) storeBase64Image:(NSString*)base64String width:(NSInteger)width imageNumber:(NSInteger)imageNumber
NS_SWIFT_NAME(storeBase64Image(_:width:imageNumber:));

- (MPOS_RESULT) clearIamge:(NSInteger)imageNumber;

- (MPOS_RESULT) clearScreen;

- (MPOS_RESULT) showCursor:(NSInteger)cursor;

@end

@interface MPosControllerPrinter (MSR)

- (MPOS_RESULT) msrReady;
- (NSString*) getTrack1Data;
- (NSString*) getTrack2Data;
- (NSString*) getTrack3Data;

@end


@interface MPosControllerPrinter (SCR)

- (MPOS_RESULT) powerUpSCR:(NSData*_Nullable*_Nullable)atrData;
- (MPOS_RESULT) powerDownSCR;
- (MPOS_RESULT) setSCROperationMode:(NSInteger)mode;
- (MPOS_RESULT) exchangeSCRData:(NSData*_Nonnull)data response:(NSData*_Nullable*_Nullable)response;
- (MPOS_RESULT) getSCRCardStatus:(NSData*_Nullable*_Nullable)status;
- (MPOS_RESULT) setSCRCardType:(NSInteger)cardType;

@end
