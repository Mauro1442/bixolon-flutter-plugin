
#import "MPosControllerDevices.h"
#import <UIKit/UIKit.h>


@interface MPosControllerLabelPrinter : MPosControllerDevices

- (NSInteger) checkPrinterStatus
NS_SWIFT_NAME(checkPrinterStatus());

- (MPOS_RESULT) checkPrinterStatus:(void(^)(NSInteger))statusBlock;
- (MPOS_RESULT) printBuffer:(NSInteger)numberOfCopies;
- (MPOS_RESULT) printRawData:(NSData*)rawData;

//  GETTER APIs
- (NSString*) getModelName;
- (MPOS_RESULT) getModelName: (void(^)(NSString*))modelNameBlock;
- (NSString*) getFirmwareVersion;
- (MPOS_RESULT) getFirmwareVersion: (void(^)(NSString*))firmwareVersionBlock;
- (NSInteger) getPrinterDPI
NS_SWIFT_NAME(getPrinterDPI());
- (NSInteger) getMaxWidth;
- (NSString*) getStatisticsData:(NSInteger)info;
- (NSArray<NSNumber*>*) getSupportedSpeeds;

//  SETTER APIs
- (MPOS_RESULT) setCharacterset:(NSInteger)characterset internationalCharset:(NSInteger)internationalCharset;
- (MPOS_RESULT) setTextEncoding:(NSInteger)textEncoding;
- (MPOS_RESULT) setPrintingType:(char)printingType;
- (MPOS_RESULT) setMargin:(NSInteger)horizontalMargin verticalMargin:(NSInteger)verticalMargin;
- (MPOS_RESULT) setBackFeedOption:(BOOL)enable stepQuantity:(NSInteger)stepQuantity;
- (MPOS_RESULT) setLength:(NSInteger)labelLength
                gapLength:(NSInteger)gapLength
                mediaType:(char)mediaType
             offsetLength:(NSInteger)offsetLength;
- (MPOS_RESULT) setWidth:(NSInteger)labelWidth;
- (MPOS_RESULT) setBufferMode:(BOOL)doubleBuffer;
- (MPOS_RESULT) setSpeed:(NSInteger)speed;
- (MPOS_RESULT) setDensity:(NSInteger)density;
- (MPOS_RESULT) setOrientation:(char)orientation;
- (MPOS_RESULT) setOffset:(NSInteger)offset;
- (MPOS_RESULT) setCuttingPosition:(NSInteger)cuttiongPosition;
- (MPOS_RESULT) setAutoCutter:(BOOL)enableAutoCutter cuttingPeriod:(NSInteger)cuttingPeriod;
- (MPOS_RESULT) setRewinder:(BOOL)enable;

// PRINTING APIs
- (MPOS_RESULT) drawImage:(UIImage*) image
                     xPos:(NSInteger)xPos
                     yPos:(NSInteger)yPos
                    width:(NSInteger)width
NS_SWIFT_NAME(drawImage(_:xPos:yPos:width:));

- (MPOS_RESULT) drawImage:(UIImage*)image
                     xPos:(NSInteger)xPos
                     yPos:(NSInteger)yPos
                    width:(NSInteger)width
               brightness:(NSInteger)brightness
              isDithering:(BOOL)isDithering
               isCompress:(BOOL)isCompress
NS_SWIFT_NAME(drawImage(_:xPos:yPos:width:brightness:isDithering:isCompress:));

- (MPOS_RESULT) drawImageFile:(NSString*)filePath
                         xPos:(NSInteger)xPos
                         yPos:(NSInteger)yPos
                        width:(NSInteger)width
                   brightness:(NSInteger)brightness
                  isDithering:(BOOL)isDithering
                   isCompress:(BOOL)isCompress
NS_SWIFT_NAME(drawImageFile(_:xPos:yPos:width:brightness:isDithering:isCompress:));

- (MPOS_RESULT) drawImageWithBase64:(NSString*)base64String
                               xPos:(NSInteger)xPos
                               yPos:(NSInteger)yPos
                              width:(NSInteger)width
                         brightness:(NSInteger)brightness
                        isDithering:(BOOL)isDithering
                         isCompress:(BOOL)isCompress
NS_SWIFT_NAME(drawImageWithBase64(_:xPos:yPos:width:brightness:isDithering:isCompress:));

- (MPOS_RESULT) drawImage:(UIImage*)image
                     xPos:(NSInteger)xPos
                     yPos:(NSInteger)yPos
                    width:(NSInteger)width
                threshold:(NSInteger)threshold
            ditheringType:(NSInteger)ditheringType
             compressType:(NSInteger)compressType
NS_SWIFT_NAME(drawImage(_:xPos:yPos:width:threshold:ditheringType:compressType:));

- (MPOS_RESULT) drawImageFile:(NSString*)filename
                         xPos:(NSInteger)xPos
                         yPos:(NSInteger)yPos
                        width:(NSInteger)width
                    threshold:(NSInteger)threshold
                ditheringType:(NSInteger)ditheringType
                 compressType:(NSInteger)compressType
NS_SWIFT_NAME(drawImageFile(_:xPos:yPos:width:threshold:ditheringType:compressType:));

- (MPOS_RESULT) drawBase64Image:(NSString*)base64String
                           xPos:(NSInteger)xPos
                           yPos:(NSInteger)yPos
                          width:(NSInteger)width
                      threshold:(NSInteger)threshold
                  ditheringType:(NSInteger)ditheringType
                   compressType:(NSInteger)compressType
NS_SWIFT_NAME(drawBase64Image(_:xPos:yPos:width:threshold:ditheringType:compressType:));

- (MPOS_RESULT) drawPDFFile:(NSString*)filename
                       posX:(NSInteger)posX
                       posY:(NSInteger)posY
                      width:(NSInteger)width
                 pageNumber:(NSInteger)pageNumber
                  threshold:(NSInteger)threshold
              ditheringType:(NSInteger)ditheringType
               compressType:(NSInteger)compressType
NS_SWIFT_NAME(drawPDFFile(_:xPos:yPos:width:pageNumber:threshold:ditheringType:compressType:));

- (MPOS_RESULT) drawTextDeviceFont:(NSString*)data
                              xPos:(NSInteger)xPos
                              yPos:(NSInteger)yPos
                     fontSelection:(char)fontSelection
                         fontWidth:(NSInteger)fontWidth
                        fontHeight:(NSInteger)fontHeight
                        rightSpace:(NSInteger)rightSpace
                          rotation:(NSInteger)rotation
                           reverse:(BOOL)reverse
                              bold:(BOOL)bold
                       rightToLeft:(BOOL)rightToLeft
                         alignment:(NSInteger)alignment;

- (MPOS_RESULT) drawTextVectorFont:(NSString*)data
                              xPos:(NSInteger)xPos
                              yPos:(NSInteger)yPos
                     fontSelection:(char)fontSelection
                         fontWidth:(NSInteger)fontWidth
                        fontHeight:(NSInteger)fontHeight
                        rightSpace:(NSInteger)rightSpace
                          rotation:(NSInteger)rotation
                           reverse:(BOOL)reverse
                              bold:(BOOL)bold
                            italic:(BOOL)italic
                       rightToLeft:(BOOL)rightToLeft
                         alignment:(NSInteger)alignment;

- (MPOS_RESULT) drawBarcode1D:(NSString*)data
                         xPos:(NSInteger)xPos
                         yPos:(NSInteger)yPos
                  barcodeType:(NSInteger)barcodeType
                  widthNarrow:(NSInteger)widthNarrow
                    widthWide:(NSInteger)widthWide
                       height:(NSInteger)height
                          hri:(NSInteger)hri
               quietZoneWidth:(NSInteger)quietZoneWidth
                     rotation:(NSInteger)rotation;

- (MPOS_RESULT) drawBarcodeMaxiCode:(NSString*)data
                               xPos:(NSInteger)xPos
                               yPos:(NSInteger)yPos
                               mode:(NSInteger)mode;

- (MPOS_RESULT) drawBarcodePDF417:(NSString*)data
                             xPos:(NSInteger)xPos
                             yPos:(NSInteger)yPos
                  maximumRowCount:(NSInteger)maximumRowCount
               maximumColumnCount:(NSInteger)maximumColumnCount
             errorCorrectionLevel:(NSInteger)errorCorrectionLevel
            dataCompressionMethod:(NSInteger)dataCompressionMethod
                              hri:(BOOL)hri
                    startPosition:(NSInteger)startPosition
                      moduleWidth:(NSInteger)moduleWidth
                        barHeight:(NSInteger)barHeight rotation:(NSInteger)rotation;

- (MPOS_RESULT) drawBarcodeQRCode:(NSString*)data
                             xPos:(NSInteger)xPos
                             yPos:(NSInteger)yPos
                             size:(NSInteger)size
                            model:(NSInteger)model
                         eccLevel:(NSInteger)eccLevel
                         rotation:(NSInteger)rotation;

- (MPOS_RESULT) drawBarcodeDataMatrix:(NSString*)data
                                 xPos:(NSInteger)xPos
                                 yPos:(NSInteger)yPos
                                 size:(NSInteger)size
                              reverse:(BOOL)reverse
                             rotation:(NSInteger)rotation;

- (MPOS_RESULT) drawBarcodeAztec:(NSString*)data
                            xPos:(NSInteger)xPos
                            yPos:(NSInteger)yPos
                            size:(NSInteger)size
                 extendedChannel:(BOOL)extendedChannel
                        eccLevel:(NSInteger)eccLevel
                      menuSymbol:(BOOL)menuSymbol
                 numberOfSymbols:(NSInteger)numberOfSymbols
                      optionalID:(NSString*)optionalID
                        rotation:(NSInteger)rotation;

- (MPOS_RESULT) drawBarcodeCode49:(NSString*)data
                             xPos:(NSInteger)xPos
                             yPos:(NSInteger)yPos
                      widthNarrow:(NSInteger)widthNarrow
                        widthWide:(NSInteger)widthWide
                           height:(NSInteger)height
                              hri:(NSInteger)hri
                     startingMode:(NSInteger)startingMode
                         rotation:(NSInteger)rotation;

-(MPOS_RESULT) drawBarcodeCodaBlock:(NSString*)data
                               xPos:(NSInteger)xPos
                               yPos:(NSInteger)yPos
                        widthNarrow:(NSInteger)widthNarrow
                          widthWide:(NSInteger)widthWide
                             height:(NSInteger)height
                      securityLevel:(BOOL)securityLevel
                        dataColumns:(NSInteger)dataColumns
                               mode:(char)mode
                       rowsToEncode:(NSInteger)rowsToEncode;

- (MPOS_RESULT) drawBarcodeMicroPDF:(NSString*)data
                               xPos:(NSInteger)xPos
                               yPos:(NSInteger)yPos
                        moduleWidth:(NSInteger)moduleWidth
                             height:(NSInteger)height
                               mode:(NSInteger)mode
                           rotation:(NSInteger)rotation;


- (MPOS_RESULT) drawBarcodeIMB:(NSString*)data
                          xPos:(NSInteger)xPos
                          yPos:(NSInteger)yPos
                           hri:(BOOL)hri
                      rotation:(NSInteger)rotation;

- (MPOS_RESULT) drawBarcodeMSI:(NSString*)data
                          xPos:(NSInteger)xPos
                          yPos:(NSInteger)yPos
                   widthNarrow:(NSInteger)widthNarrow
                     widthWide:(NSInteger)widthWide
                        height:(NSInteger)height
                    checkDigit:(NSInteger)checkDigit
               printCheckDigit:(BOOL)printCheckDigit
                           hri:(NSInteger)hri
                      rotation:(NSInteger)rotation;


- (MPOS_RESULT) drawBarcodePlessey:(NSString*)data
                              xPos:(NSInteger)xPos
                              yPos:(NSInteger)yPos
                       widthNarrow:(NSInteger)widthNarrow
                         widthWide:(NSInteger)widthWide
                            height:(NSInteger)height
                   printCheckDigit:(BOOL)printCheckDigit
                               hri:(NSInteger)hri
                          rotation:(NSInteger)rotation;

- (MPOS_RESULT) drawBarcodeTLC39:(NSString*)data
                            xPos:(NSInteger)xPos
                            yPos:(NSInteger)yPos
                     widthNarrow:(NSInteger)widthNarrow
                       widthWide:(NSInteger)widthWide
                          height:(NSInteger)height
          rowHeightOfMicroPDF417:(NSInteger)rowHeightOfMicroPDF417
        narrowWidthOfMicroPDF417:(NSInteger)narrowWidthOfMicroPDF417
                        rotation:(NSInteger)rotation;

- (MPOS_RESULT) drawBarcodeRSS:(NSString*)data
                          xPos:(NSInteger)xPos
                          yPos:(NSInteger)yPos
                   barcodeType:(NSInteger)barcodeType
                 magnification:(NSInteger)magnification
               separatorHeight:(NSInteger)separatorHeight
                        height:(NSInteger)height
                  segmentWidth:(NSInteger)segmentWidth
                      rotation:(NSInteger)rotation;

- (MPOS_RESULT) drawBlock:(NSInteger)startPosX
                startPosY:(NSInteger)startPosY
                  endPosX:(NSInteger)endPosX
                  endPosY:(NSInteger)endPosY
                   option:(char)option
                thickness:(NSInteger)thickness;

- (MPOS_RESULT) drawCircle:(NSInteger)startPosX
                 startPosY:(NSInteger)startPosY
                      size:(NSInteger)size
                multiplier:(NSInteger)multiplier;

@end


@interface MPosControllerLabelPrinter (RFID)

- (MPOS_RESULT) setupRFID:(NSInteger)rfidType
          numberOfRetries:(NSInteger)numberOfRetries
            numberOfLabel:(NSInteger)numberOfLabel
               radioPower:(NSInteger)radioPower;

- (MPOS_RESULT) setRFIDPosition:(NSInteger)transPosition;

- (MPOS_RESULT) writeRFID:(NSInteger)dataType
      startingBlockNumber:(NSInteger)startingBlockNumber
               dataLength:(NSInteger)dataLength
                     data:(NSString*)data;

- (MPOS_RESULT) setRFIDPassword:(NSString *)oldAccessPwd
                     oldKillPwd:(NSString *)oldKillPwd
                   newAccessPwd:(NSString *)newAccessPwd
                     newKillPwd:(NSString *)newKillPwd;

- (MPOS_RESULT) setEPCDataStructure:(NSInteger)totalSize
                         fieldSizes:(NSString *)fieldSizes;

- (MPOS_RESULT) calibrateRFID;

- (MPOS_RESULT) lockRFID;

@end
