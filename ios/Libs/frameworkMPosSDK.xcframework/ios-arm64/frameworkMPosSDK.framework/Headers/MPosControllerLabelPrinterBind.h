
#import "MPosControllerLabelPrinter.h"
#import <UIKit/UIKit.h>


@interface MPosControllerLabelPrinterBind : MPosControllerLabelPrinter

-(MPOS_RESULT) setBackFeedOption:(NSInteger)enable stepQuantity:(NSInteger)stepQuantity;

-(MPOS_RESULT) setAutoCutter:(NSInteger)enableAutoCutter cuttingPeriod:(NSInteger)cuttingPeriod;

-(MPOS_RESULT) drawTextDeviceFont:(NSString*)data
                             xPos:(NSInteger)xPos
                             yPos:(NSInteger)yPos
                    fontSelection:(char)fontSelection
                        fontWidth:(NSInteger)fontWidth
                       fontHeight:(NSInteger)fontHeight
                       rightSpace:(NSInteger)rightSpace
                         rotation:(NSInteger)rotation
                          reverse:(NSInteger)reverse
                             bold:(NSInteger)bold
                      rightToLeft:(NSInteger)rightToLeft
                        alignment:(NSInteger)alignment;

-(MPOS_RESULT) drawTextVectorFont:(NSString*)data
                             xPos:(NSInteger)xPos
                             yPos:(NSInteger)yPos
                    fontSelection:(char)fontSelection
                        fontWidth:(NSInteger)fontWidth
                       fontHeight:(NSInteger)fontHeight
                       rightSpace:(NSInteger)rightSpace
                         rotation:(NSInteger)rotation
                          reverse:(NSInteger)reverse
                             bold:(NSInteger)bold
                           italic:(NSInteger)italic
                      rightToLeft:(NSInteger)rightToLeft
                        alignment:(NSInteger)alignment;

-(MPOS_RESULT) drawBarcodePDF417:(NSString*)data
                            xPos:(NSInteger)xPos
                            yPos:(NSInteger)yPos
                 maximumRowCount:(NSInteger)maximumRowCount
              maximumColumnCount:(NSInteger)maximumColumnCount
            errorCorrectionLevel:(NSInteger)errorCorrectionLevel
           dataCompressionMethod:(NSInteger)dataCompressionMethod
                             hri:(NSInteger)hri
                   startPosition:(NSInteger)startPosition
                     moduleWidth:(NSInteger)moduleWidth
                       barHeight:(NSInteger)barHeight
                        rotation:(NSInteger)rotation;

-(MPOS_RESULT) drawBarcodeDataMatrix:(NSString*)data
                                xPos:(NSInteger)xPos
                                yPos:(NSInteger)yPos
                                size:(NSInteger)size
                             reverse:(NSInteger)reverse
                            rotation:(NSInteger)rotation;

-(MPOS_RESULT) drawBarcodeAztec:(NSString*)data
                           xPos:(NSInteger)xPos
                           yPos:(NSInteger)yPos
                           size:(NSInteger)size
                extendedChannel:(NSInteger)extendedChannel
                       eccLevel:(NSInteger)eccLevel
                     menuSymbol:(NSInteger)menuSymbol
                numberOfSymbols:(NSInteger)numberOfSymbols
                     optionalID:(NSString*)optionalID
                       rotation:(NSInteger)rotation;

-(MPOS_RESULT) drawBarcodeCodaBlock:(NSString*)data
                                   xPos:(NSInteger)xPos
                                   yPos:(NSInteger)yPos
                            widthNarrow:(NSInteger)widthNarrow
                              widthWide:(NSInteger)widthWide
                                 height:(NSInteger)height
                          securityLevel:(NSInteger)securityLevel
                            dataColumns:(NSInteger)dataColumns
                                   mode:(char)mode
                       rowsToEncode:(NSInteger)rowsToEncode;

-(MPOS_RESULT) drawBarcodeIMB:(NSString*)data
                          xPos:(NSInteger)xPos
                          yPos:(NSInteger)yPos
                           hri:(NSInteger)hri
                      rotation:(NSInteger)rotation;

-(MPOS_RESULT) drawBarcodeMSI:(NSString*)data
                         xPos:(NSInteger)xPos
                         yPos:(NSInteger)yPos
                  widthNarrow:(NSInteger)widthNarrow
                    widthWide:(NSInteger)widthWide
                       height:(NSInteger)height
                   checkDigit:(NSInteger)checkDigit
              printCheckDigit:(NSInteger)printCheckDigit
                          hri:(NSInteger)hri
                     rotation:(NSInteger)rotation;

-(MPOS_RESULT) drawBarcodePlessey:(NSString*)data
                             xPos:(NSInteger)xPos
                             yPos:(NSInteger)yPos
                      widthNarrow:(NSInteger)widthNarrow
                        widthWide:(NSInteger)widthWide
                           height:(NSInteger)height
                  printCheckDigit:(NSInteger)printCheckDigit
                              hri:(NSInteger)hri
                         rotation:(NSInteger)rotation;

-(MPOS_RESULT) drawImageWithBase64:(NSString*)base64String
                              xPos:(NSInteger)xPos
                              yPos:(NSInteger)yPos
                             width:(NSInteger)width
                        brightness:(NSInteger)brightness
                       isDithering:(NSInteger)isDithering
                        isCompress:(NSInteger)isCompress;

-(MPOS_RESULT) drawImage:(UIImage*)image
                    xPos:(NSInteger)xPos
                    yPos:(NSInteger)yPos
                   width:(NSInteger)width
              brightness:(NSInteger)brightness
             isDithering:(NSInteger)isDithering
              isCompress:(NSInteger)isCompress;

-(MPOS_RESULT)drawImageFile:(NSString*)filePath
                       xPos:(NSInteger)xPos
                       yPos:(NSInteger)yPos
                      width:(NSInteger)width
                 brightness:(NSInteger)brightness
                isDithering:(NSInteger)isDithering
                 isCompress:(NSInteger)isCompress;

@end

