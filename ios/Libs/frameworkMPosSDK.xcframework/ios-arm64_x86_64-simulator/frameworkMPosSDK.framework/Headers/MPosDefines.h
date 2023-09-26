

typedef NS_ENUM(NSInteger, MPOS_PORT_CLOSE){
    MPOS_CLOSE_TIMEOUT_IMMEDIATELY  = 0,
    MPOS_CLOSE_TIMEOUT_INFINITE     = 1,
};

typedef NS_ENUM(NSInteger, MPOS_CAHDRAWR_PIN) {
    MPOS_CASHDRAWER_PIN2    = 0,
    MPOS_CASHDRAWER_PIN5    = 1,
    POS_DRAWER_PIN2         = 0,
    POS_DRAWER_PIN5         = 1,
};

typedef NS_ENUM(NSInteger, MPOS_IMAGE_PRINT_WIDTH){
    MPOS_IMAGE_WIDTH_ASIS   = -2,
    POS_IMAGE_WIDTH_ASIS    = -2
};

typedef NS_ENUM(NSInteger, MPOS_INTERACE_TYPE) {
    MPOS_INTERFACE_WIFI         = 1,
    MPOS_INTERFACE_ETHERNET     = 2,
    MPOS_INTERFACE_BLUETOOTH    = 4,
    MPOS_INTERFACE_BLE          = 8,
};

typedef NS_ENUM(NSInteger, MPOS_COMMAND_MODE){
    MPOS_COMMAND_MODE_DEFAULT   = 0,
    MPOS_MODE_DEFAULT           = 0,
    MPOS_COMMAND_MODE_BYPASS    = 1,
    MPOS_MODE_BYPASS            = 1,
};

typedef NS_ENUM(NSInteger, MPOS_PRINTER_CUTTYPE) {
    MPOS_PRINTER_CUTPAPER      = 0,
    MPOS_PRINTER_FEEDCUT       = 65,
    POS_NO_FEED_PARTIAL_CUT    = 0,
    POS_NO_FEED_FULL_CUT       = 1,
    POS_FEED_PARTIAL_CUT       = 65,
    POS_FEED_FULL_CUT          = 66,
};

typedef NS_ENUM(NSInteger, MPOS_DEVICE_TYPE){
    MPOS_DEVICE_LABEL_PRINTER          = 1,
    MPOS_DEVICE_PRINTER                = 10,
    MPOS_DEVICE_MSR                    = 30,
    MPOS_DEVICE_SCANNER                = 40,
    MPOS_DEVICE_RFID                   = 60,
    MPOS_DEVICE_DALLASKEY              = 70,
    MPOS_DEVICE_NFC                    = 80,
    MPOS_DEVICE_DISPLAY                = 110,
    MPOS_DEVICE_USB_TO_SERIAL          = 120,
    MPOS_DEVICE_SCALE                  = 130,
};

typedef NS_ENUM(NSInteger, MPOS_ALIGNMENT){
    MPOS_ALIGNMENT_DEFAULT  = -1,
    MPOS_ALIGNMENT_LEFT     = 0,
    MPOS_ALIGNMENT_CENTER   = 1,
    MPOS_ALIGNMENT_RIGHT    = 2,
    POS_ALIGNMENT_DEFAULT  = -1,
    POS_ALIGNMENT_LEFT     = 0,
    POS_ALIGNMENT_CENTER   = 1,
    POS_ALIGNMENT_RIGHT    = 2,
};

typedef NS_ENUM(NSInteger, MPOS_BARCODE_TEXT_POSITION){
    MPOS_BARCODE_TEXT_NONE  = 0,
    MPOS_BARCODE_TEXT_ABOVE = 1,
    MPOS_BARCODE_TEXT_BELOW = 2,
    MPOS_BARCODE_TEXT_BOTH  = 3,
    POS_BARCODE_TEXT_NONE   = 0,
    POS_BARCODE_TEXT_ABOVE  = 1,
    POS_BARCODE_TEXT_BELOW  = 2,
    POS_BARCODE_TEXT_BOTH   = 3,
};

typedef NS_ENUM(NSInteger, MPOS_BARCODE_TYPE){
    MPOS_BARCODE_UPCA                               = 101,
    MPOS_BARCODE_UPCE                               = 102,
    MPOS_BARCODE_EAN8                               = 103,
    MPOS_BARCODE_JAN8                               = 103,
    MPOS_BARCODE_EAN13                              = 104,
    MPOS_BARCODE_JAN13                              = 104,
    MPOS_BARCODE_ITF                                = 106,
    MPOS_BARCODE_CODABAR                            = 107,
    MPOS_BARCODE_CODE39                             = 108,
    MPOS_BARCODE_CODE93                             = 109,
    MPOS_BARCODE_CODE128                            = 110,
    MPOS_BARCODE_GS1_128                            = 111,
    MPOS_BARCODE_GS1DATABAR_OMNIDIRECTIONAL         = 112,
    MPOS_BARCODE_GS1DATABAR_TRUNCATED               = 113,
    MPOS_BARCODE_GS1DATABAR_LIMITED                 = 114,
    
    POS_BARCODE_UPCA                                = 101,
    POS_BARCODE_UPCE                                = 102,
    POS_BARCODE_EAN8                                = 103,
    POS_BARCODE_JAN8                                = 103,
    POS_BARCODE_EAN13                               = 104,
    POS_BARCODE_JAN13                               = 104,
    POS_BARCODE_ITF                                 = 106,
    POS_BARCODE_CODABAR                             = 107,
    POS_BARCODE_CODE39                              = 108,
    POS_BARCODE_CODE93                              = 109,
    POS_BARCODE_CODE128                             = 110,
    POS_BARCODE_GS1_128                             = 111,
    POS_BARCODE_GS1DATABAR_OMNIDIRECTIONAL          = 112,
    POS_BARCODE_GS1DATABAR_TRUNCATED                = 113,
    POS_BARCODE_GS1DATABAR_LIMITED                  = 114,
};

typedef NS_ENUM(NSInteger, MPOS_QRCODE_MODEL){
    MPOS_BARCODE_QRCODE_MODEL1                      = 204,
    MPOS_BARCODE_QRCODE_MODEL2                      = 205,
    POS_QRCODE_MODEL1                               = 204,
    POS_QRCODE_MODEL2                               = 205,
};
    
typedef NS_ENUM(NSInteger, MPOS_QRCODE_ECC_LEVEL){
    MPOS_QRCODE_ECC_LEVEL_L = 48,
    MPOS_QRCODE_ECC_LEVEL_M = 49,
    MPOS_QRCODE_ECC_LEVEL_Q = 50,
    MPOS_QRCODE_ECC_LEVEL_H = 51,
    POS_QRCODE_ECC_L        = 48,
    POS_QRCODE_ECC_M        = 49,
    POS_QRCODE_ECC_Q        = 50,
    POS_QRCODE_ECC_H        = 51
};

typedef NS_ENUM(NSInteger, MPOS_PDF417_TYPE){
    MPOS_BARCODE_PDF417                 = 201,
    MPOS_BARCODE_PDF417_SIMPLIFIED      = 202,
    POS_PDF417                          = 201,
    POS_PDF417_SIMPLIFIED               = 202,
};

typedef NS_ENUM(NSInteger, MPOS_PDF417_ECC_LEVEL){
    MPOS_PDF417_ECC_LEVEL_0 = 0,
    MPOS_PDF417_ECC_LEVEL_1 = 1,
    MPOS_PDF417_ECC_LEVEL_2 = 2,
    MPOS_PDF417_ECC_LEVEL_3 = 3,
    MPOS_PDF417_ECC_LEVEL_4 = 4,
    MPOS_PDF417_ECC_LEVEL_5 = 5,
    MPOS_PDF417_ECC_LEVEL_6 = 6,
    MPOS_PDF417_ECC_LEVEL_7 = 7,
    MPOS_PDF417_ECC_LEVEL_8 = 8,
    POS_PDF417_ECC_LEVEL_0  = 0,
    POS_PDF417_ECC_LEVEL_1  = 1,
    POS_PDF417_ECC_LEVEL_2  = 2,
    POS_PDF417_ECC_LEVEL_3  = 3,
    POS_PDF417_ECC_LEVEL_4  = 4,
    POS_PDF417_ECC_LEVEL_5  = 5,
    POS_PDF417_ECC_LEVEL_6  = 6,
    POS_PDF417_ECC_LEVEL_7  = 7,
    POS_PDF417_ECC_LEVEL_8  = 8
};

typedef NS_ENUM(NSInteger, MPOS_MAXICODE_MODE) {
    POS_MAXICODE_MODE_0 = 0,
    POS_MAXICODE_MODE_2 = 2,
    POS_MAXICODE_MODE_3 = 3,
    POS_MAXICODE_MODE_4 = 4,
};

typedef NS_ENUM(NSInteger, MPOS_AZTEC_MODE) {
    POS_AZTEC_MODE_DATA     = 0,
    POS_AZTEC_MODE_GS1      = 1,
    POS_AZTEC_MODE_UNICODE  = 2,
};

typedef NS_ENUM(NSInteger, MPOS_AZTEC_ECC) {
    POS_AZTEC_ECC_L     = 48,
    POS_AZTEC_ECC_M     = 49,
    POS_AZTEC_ECC_Q     = 50,
    POS_AZTEC_ECC_H     = 51,
};

typedef NS_ENUM(NSInteger, MPOS_COMPOSITE_1D) {
    POS_COMPOSITE_EAN8                      = 65,
    POS_COMPOSITE_EAN13                     = 66,
    POS_COMPOSITE_UPC_A                     = 67,
    POS_COMPOSITE_UPC_E                     = 69,
    POS_COMPOSITE_GS1_DATABAR_OMNI          = 70,
    POS_COMPOSITE_GS1_DATABAR_TRUNCATED     = 71,
    POS_COMPOSITE_GS1_DATABAR_STACKED       = 72,
    POS_COMPOSITE_GS1_DATABAR_STACKED_OMNI  = 73,
    POS_COMPOSITE_GS1_DATABAR_LIMITED       = 74,
    POS_COMPOSITE_GS1_DATABAR_EXPANDED      = 75,
    POS_COMPOSITE_GS1_128                   = 77,
};

typedef NS_ENUM(NSInteger, MPOS_POS_COMPOSITE_2D) {
    POS_COMPOSITE_CC_AUTOMATIC              = 65,
    POS_COMPOSITE_CC_C                      = 66,
};

typedef NS_ENUM(NSInteger, MPOS_GS1DATABAR) {
    POS_GS1DATABAR_OMNI             = 50,
    POS_GS1DATABAR_TRUNCATED        = 51,
    POS_GS1DATABAR_STACKED          = 52,
    POS_GS1DATABAR_STACKED_OMNI     = 53,
    POS_GS1DATABAR_UPC_A            = 56,
    POS_GS1DATABAR_UPC_E            = 57,
    POS_GS1DATABAR_EAN13            = 58,
    POS_GS1DATABAR_EAN8             = 59,
    POS_GS1DATABAR_EAN128_CC_A_B    = 60,
    POS_GS1DATABAR_EAN128_CC_C      = 61,
};

typedef NS_ENUM(NSInteger, MPOS_CUSTOMDEVICE){
    MPOS_CUSTOMDEVICE_POSPRINTER                  = 0,
    MPOS_CUSTOMDEVICE_LABELPRINTER                = 1,
    MPOS_CUSTOMDEVICE_MSR                         = 2,
    MPOS_CUSTOMDEVICE_SCANNER                     = 3,
    MPOS_CUSTOMDEVICE_RFID                        = 4,
    MPOS_CUSTOMDEVICE_DALLASKEY                   = 5,
    MPOS_CUSTOMDEVICE_NFC                         = 6,
    MPOS_CUSTOMDEVICE_BCD                         = 7
};

typedef NS_ENUM(NSInteger, MPOS_CODEPAGE){
    MPOS_CODEPAGE_PC437             = 0,     // USA Standard Europe
    MPOS_CODEPAGE_KATAKANA          = 1,     // Japanese
    MPOS_CODEPAGE_PC850             = 2,     // OEM Multilingual Latin1 Western European
    MPOS_CODEPAGE_PC860             = 3,     // OEM Portuguese
    MPOS_CODEPAGE_PC863             = 4,     // OEM French
    MPOS_CODEPAGE_PC865             = 5,     // OEM Nordic
    MPOS_CODEPAGE_WPC1252           = 16,    // ANSI Latin 1 Western European
    MPOS_CODEPAGE_PC866             = 17,    // OEM Russian Cyrillic (DOS)
    MPOS_CODEPAGE_PC852             = 18,    // OEM Latin 2 Central European
    MPOS_CODEPAGE_PC858             = 19,    // OEM Multilingual Latin 1 + Euro Symbol
    MPOS_CODEPAGE_PC862             = 21,    // OEM Hebrew
    MPOS_CODEPAGE_PC864             = 22,    // Arabic
    MPOS_CODEPAGE_THAI42            = 23,    // Thai42
    MPOS_CODEPAGE_WPC1253           = 24,    // ANSI Greek
    MPOS_CODEPAGE_WPC1254           = 25,    // ANSI Turkish
    MPOS_CODEPAGE_WPC1257           = 26,    // ANSI Baltic
    MPOS_CODEPAGE_FARSI             = 27,    // Farsi
    MPOS_CODEPAGE_WPC1251           = 28,    // ANSI Cyrillic
    MPOS_CODEPAGE_PC737             = 29,    // OEM Greek
    MPOS_CODEPAGE_PC775             = 30,    // OEM Baltic
    MPOS_CODEPAGE_THAI14            = 31,    // Thai14
    MPOS_CODEPAGE_HEBREW_OLD        = 32,    // Hebrew OLD
    MPOS_CODEPAGE_WPC1255           = 33,    // ANSI Hebrew
    MPOS_CODEPAGE_THAI11            = 34,    // Thai11
    MPOS_CODEPAGE_THAI18            = 35,    // Thai18
    MPOS_CODEPAGE_PC855             = 36,    // OEM Cyrillic (Primarily Russian)
    MPOS_CODEPAGE_PC857             = 37,    // Turkish
    MPOS_CODEPAGE_PC928             = 38,    // Greek
    MPOS_CODEPAGE_THAI16            = 39,    // Thai16
    MPOS_CODEPAGE_WPC1256           = 40,    // Arabic
    MPOS_CODEPAGE_WPC1258           = 41,    // Vietnam
    MPOS_CODEPAGE_KHMER             = 42,    // Cambodia
    MPOS_CODEPAGE_WPC1250           = 47,    // Czech
    MPOS_CODEPAGE_LATIN9            = 48,    // Latin9
    MPOS_CODEPAGE_TCVN3             = 49,    // Vietnam (TCVN3)
    MPOS_CODEPAGE_TCVN3_CAPITAL     = 50,    // Vietnam (TCVN3 CAPITAL)
    MPOS_CODEPAGE_VISCII            = 51,    // Vietnam (VISCII)
    MPOS_CODEPAGE_PC912             = 52,    // Albanian
    MPOS_CODEPAGE_KS5601            = 949,   // Korean
    MPOS_CODEPAGE_SHIFTJIS          = 932,   // Japanese
    MPOS_CODEPAGE_BIG5              = 950,   // Chinese (Traditional)
    MPOS_CODEPAGE_GB2312            = 936,   // Chinese (Simplified)
    MPOS_CODEPAGE_GB18030           = 54936, // Chinese
    MPOS_CODEPAGE_UTF8              = 54937, // UTF-8
    MPOS_CODEPAGE_UTF16             = 54938, // UTF-16
    MPOS_CODEPAGE_UTF32             = 54939, // UTF-32
    POS_CODEPAGE_PC437              = 0,     // USA Standard Europe
    POS_CODEPAGE_KATAKANA           = 1,     // Japanese
    POS_CODEPAGE_PC850              = 2,     // OEM Multilingual Latin1 Western European
    POS_CODEPAGE_PC860              = 3,     // OEM Portuguese
    POS_CODEPAGE_PC863              = 4,     // OEM French
    POS_CODEPAGE_PC865              = 5,     // OEM Nordic
    POS_CODEPAGE_WPC1252            = 16,    // ANSI Latin 1 Western European
    POS_CODEPAGE_PC866              = 17,    // OEM Russian Cyrillic (DOS)
    POS_CODEPAGE_PC852              = 18,    // OEM Latin 2 Central European
    POS_CODEPAGE_PC858              = 19,    // OEM Multilingual Latin 1 + Euro Symbol
    POS_CODEPAGE_PC862              = 21,    // OEM Hebrew
    POS_CODEPAGE_PC864              = 22,    // Arabic
    POS_CODEPAGE_THAI42             = 23,    // Thai42
    POS_CODEPAGE_WPC1253            = 24,    // ANSI Greek
    POS_CODEPAGE_WPC1254            = 25,    // ANSI Turkish
    POS_CODEPAGE_WPC1257            = 26,    // ANSI Baltic
    POS_CODEPAGE_FARSI              = 27,    // Farsi
    POS_CODEPAGE_WPC1251            = 28,    // ANSI Cyrillic
    POS_CODEPAGE_PC737              = 29,    // OEM Greek
    POS_CODEPAGE_PC775              = 30,    // OEM Baltic
    POS_CODEPAGE_THAI14             = 31,    // Thai14
    POS_CODEPAGE_HEBREW_OLD         = 32,    // Hebrew OLD
    POS_CODEPAGE_WPC1255            = 33,    // ANSI Hebrew
    POS_CODEPAGE_THAI11             = 34,    // Thai11
    POS_CODEPAGE_THAI18             = 35,    // Thai18
    POS_CODEPAGE_PC855              = 36,    // OEM Cyrillic (Primarily Russian)
    POS_CODEPAGE_PC857              = 37,    // Turkish
    POS_CODEPAGE_PC928              = 38,    // Greek
    POS_CODEPAGE_THAI16             = 39,    // Thai16
    POS_CODEPAGE_WPC1256            = 40,    // Arabic
    POS_CODEPAGE_WPC1258            = 41,    // Vietnam
    POS_CODEPAGE_KHMER              = 42,    // Cambodia
    POS_CODEPAGE_WPC1250            = 47,    // Czech
    POS_CODEPAGE_LATIN9             = 48,    // Latin9
    POS_CODEPAGE_TCVN3              = 49,    // Vietnam (TCVN3)
    POS_CODEPAGE_TCVN3_CAPITAL      = 50,    // Vietnam (TCVN3 CAPITAL)
    POS_CODEPAGE_VISCII             = 51,    // Vietnam (VISCII)
    POS_CODEPAGE_KS5601             = 949,   // Korean
    POS_CODEPAGE_SHIFTJIS           = 932,   // Japanese
    POS_CODEPAGE_BIG5               = 950,   // Chinese (Traditional)
    POS_CODEPAGE_GB2312             = 936,   // Chinese (Simplified)
    POS_CODEPAGE_GB18030            = 54936, // Chinese
    POS_CODEPAGE_UTF8               = 54937, // UTF-8
    POS_CODEPAGE_UTF16              = 54938, // UTF-16
    POS_CODEPAGE_UTF32              = 54939, // UTF-32
};

typedef NS_ENUM(NSInteger, MPOS_INTERNATIONAL_CODEPAGE){
    MPOS_ICS_USA                = 0,
    MPOS_ICS_FRANCE             = 1,
    MPOS_ICS_GERMANY            = 2,
    MPOS_ICS_UK                 = 3,
    MPOS_ICS_DENMARK_I          = 4,
    MPOS_ICS_SWEDEN             = 5,
    MPOS_ICS_ITALY              = 6,
    MPOS_ICS_SPAIN_I            = 7,
    MPOS_ICS_JAPAN              = 8,
    MPOS_ICS_NORWAY             = 9,
    MPOS_ICS_DENMARK_II         = 10,
    MPOS_SPAIN_II               = 11,
    MPOS_LATIN_AMERICA          = 12,
    MPOS_ICS_KOREA              = 13,
    MPOS_SLOVENIA_CROATIA       = 14,
    MPOS_ICS_CHINA              = 15,
    
    POS_ICS_USA                 = 0,
    POS_ICS_FRANCE              = 1,
    POS_ICS_GERMANY             = 2,
    POS_ICS_UK                  = 3,
    POS_ICS_DENMARK_I           = 4,
    POS_ICS_SWEDEN              = 5,
    POS_ICS_ITALY               = 6,
    POS_ICS_SPAIN_I             = 7,
    POS_ICS_JAPAN               = 8,
    POS_ICS_NORWAY              = 9,
    POS_ICS_DENMARK_II          = 10,
    POS_ICS_SPAIN_II            = 11,
    POS_ICS_LATIN_AMERICA       = 12,
    POS_ICS_KOREA               = 13,
    POS_ICS_SLOVENIA_CROATIA    = 14,
    POS_ICS_CHINA               = 15
};

typedef NS_ENUM(NSInteger, MPOS_FONT_TYPE){
    MPOS_FONT_TYPE_A       = 0,
    MPOS_FONT_TYPE_B       = 1,
    MPOS_FONT_TYPE_C       = 2,
};

typedef NS_ENUM(NSInteger, MPOS_FONT_UNDERLINE){
    MPOS_FONT_UNDERLINE_NONE  =  0,
    MPOS_FONT_UNDERLINE_1     =  1,
    MPOS_FONT_UNDERLINE_2     =  2,
};

typedef NS_ENUM(NSInteger, MPOS_FONT_SIZE_WIDTH){
    MPOS_FONT_SIZE_WIDTH_0     = 0,
    MPOS_FONT_SIZE_WIDTH_1     = 1,
    MPOS_FONT_SIZE_WIDTH_2     = 2,
    MPOS_FONT_SIZE_WIDTH_3     = 3,
    MPOS_FONT_SIZE_WIDTH_4     = 4,
    MPOS_FONT_SIZE_WIDTH_5     = 5,
    MPOS_FONT_SIZE_WIDTH_6     = 6,
    MPOS_FONT_SIZE_WIDTH_7     = 7,
}  ;

typedef NS_ENUM(NSInteger, MPOS_FONT_SIZE_HEIGHT){
    MPOS_FONT_SIZE_HEIGHT_0     = 0,
    MPOS_FONT_SIZE_HEIGHT_1     = 1,
    MPOS_FONT_SIZE_HEIGHT_2     = 2,
    MPOS_FONT_SIZE_HEIGHT_3     = 3,
    MPOS_FONT_SIZE_HEIGHT_4     = 4,
    MPOS_FONT_SIZE_HEIGHT_5     = 5,
    MPOS_FONT_SIZE_HEIGHT_6     = 6,
    MPOS_FONT_SIZE_HEIGHT_7     = 7,
};

typedef NS_ENUM(NSInteger, MPOS_SCR_MODE) {
    POS_SCR_MODE_APDU = 0,
    POS_SCR_MODE_TPDU = 1,
};

typedef NS_ENUM(NSInteger, MPOS_SCR_CARD) {
    POS_SCR_SMARTCARD   = 48,
    POS_SCR_SAM1        = 49,
    POS_SCR_SAM2        = 50,
};

typedef NS_ENUM(NSInteger, MPOS_POS_STATISTICS) {
    POS_STATS_MOTOR1  = 0,
    POS_STATS_MOTOR2  = 1,
    POS_STATS_TPH1    = 2,
    POS_STATS_TPH2    = 3,
    POS_STATS_CUT1    = 4,
    POS_STATS_CUT2    = 5,
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_ALIGNMENTS) {
    MPOS_LABEL_ALIGNMENT_LEFT                       = 0,
    MPOS_LABEL_ALIGNMENT_RIGHT                      = 1,
    MPOS_LABEL_ALIGNMENT_CENTER                     = 2,
    //MPOS_LABEL_ALIGNMENT_STRING_FROM_RIGHT_2_LEFT   = 2,
    LABEL_ALIGNMENT_LEFT                            = 0,
    LABEL_ALIGNMENT_RIGHT                           = 1,
    LABEL_ALIGNMENT_CENTER                          = 2,
    //LABEL_ALIGNMENT_RIGHT_TO_LEFT                   = 2,
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_BARCODE_HRI) {
    MPOS_LABEL_BARCODE_NONE                     = 0,
    MPOS_LABEL_BARCODE_BELOW                    = 1,
    MPOS_LABEL_BARCODE_ABOVE                    = 2,
    MPOS_LABEL_BARCODE_BELOW_FONTSIZE2          = 3,
    MPOS_LABEL_BARCODE_ABOVE_FONTSIZE2          = 4,
    MPOS_LABEL_BARCODE_BELOW_FONTSIZE3          = 5,
    MPOS_LABEL_BARCODE_ABOVE_FONTSIZE3          = 6,
    MPOS_LABEL_BARCODE_BELOW_FONTSIZE4          = 7,
    MPOS_LABEL_BARCODE_ABOVE_FONTSIZE4          = 8,
    LABEL_BARCODE_TEXT_NONE                     = 0,
    LABEL_BARCODE_TEXT_BELOW                    = 1,
    LABEL_BARCODE_TEXT_ABOVE                    = 2,
    LABEL_BARCODE_TEXT_BELOW2                   = 3,
    LABEL_BARCODE_TEXT_ABOVE2                   = 4,
    LABEL_BARCODE_TEXT_BELOW3                   = 5,
    LABEL_BARCODE_TEXT_ABOVE3                   = 6,
    LABEL_BARCODE_TEXT_BELOW4                   = 7,
    LABEL_BARCODE_TEXT_ABOVE4                   = 8,
    
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_BARCODE_TYPE) {
    MPOS_LABEL_BARCODE_TYPE_CODE39                      = 0,
    MPOS_LABEL_BARCODE_TYPE_CODE128                     = 1,
    MPOS_LABEL_BARCODE_TYPE_I2Of5                       = 2,
    MPOS_LABEL_BARCODE_TYPE_CODABAR                     = 3,
    MPOS_LABEL_BARCODE_TYPE_CODE93                      = 4,
    MPOS_LABEL_BARCODE_TYPE_UPC_A                       = 5,
    MPOS_LABEL_BARCODE_TYPE_UPC_E                       = 6,
    MPOS_LABEL_BARCODE_TYPE_EAN13                       = 7,
    MPOS_LABEL_BARCODE_TYPE_EAN8                        = 8,
    MPOS_LABEL_BARCODE_TYPE_EAN128                      = 9,
    MPOS_LABEL_BARCODE_TYPE_CODE11                      = 10,
    MPOS_LABEL_BARCODE_TYPE_PLANET                      = 11,
    MPOS_LABEL_BARCODE_TYPE_INDUSTRIAL_2Of5             = 12,
    MPOS_LABEL_BARCODE_TYPE_STANDARD_2Of5               = 13,
    MPOS_LABEL_BARCODE_TYPE_LOGMARS                     = 14,
    MPOS_LABEL_BARCODE_TYPE_UPC_EAN_EXTENSIONS          = 15,
    MPOS_LABEL_BARCODE_TYPE_POSTNET                     = 16,
    LABEL_BARCODE_CODE39                                   = 0,
    LABEL_BARCODE_CODE128                                  = 1,
    LABEL_BARCODE_I2Of5                                    = 2,
    LABEL_BARCODE_CODABAR                                  = 3,
    LABEL_BARCODE_CODE93                                   = 4,
    LABEL_BARCODE_UPC_A                                    = 5,
    LABEL_BARCODE_UPC_E                                    = 6,
    LABEL_BARCODE_EAN13                                    = 7,
    LABEL_BARCODE_EAN8                                     = 8,
    LABEL_BARCODE_UCC_EAN128                               = 9,
    LABEL_BARCODE_CODE11                                   = 10,
    LABEL_BARCODE_PLANET                                   = 11,
    LABEL_BARCODE_INDUSTRIAL_2Of5                          = 12,
    LABEL_BARCODE_STANDARD_2Of5                            = 13,
    LABEL_BARCODE_LOGMARS                                  = 14,
    LABEL_BARCODE_UPC_EAN_EXT                              = 15,
    LABEL_BARCODE_POSTNET                                  = 16,
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_MAXICODE_MODE) {
    MPOS_LABEL_MAXICODE_MODE_0  = 0,
    MPOS_LABEL_MAXICODE_MODE_2  = 2,
    MPOS_LABEL_MAXICODE_MODE_3  = 3,
    MPOS_LABEL_MAXICODE_MODE_4  = 4,
    LABEL_MAXICODE_MODE_0       = 0,
    LABEL_MAXICODE_MODE_2       = 2,
    LABEL_MAXICODE_MODE_3       = 3,
    LABEL_MAXICODE_MODE_4       = 4,
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_ERROR_CORRECTION_LEVEL) {
    MPOS_LABEL_ERROR_CORRECTION_LEVEL0           = 0,
    MPOS_LABEL_ERROR_CORRECTION_LEVEL1           = 1,
    MPOS_LABEL_ERROR_CORRECTION_LEVEL2           = 2,
    MPOS_LABEL_ERROR_CORRECTION_LEVEL3           = 3,
    MPOS_LABEL_ERROR_CORRECTION_LEVEL4           = 4,
    MPOS_LABEL_ERROR_CORRECTION_LEVEL5           = 5,
    MPOS_LABEL_ERROR_CORRECTION_LEVEL6           = 6,
    MPOS_LABEL_ERROR_CORRECTION_LEVEL7           = 7,
    MPOS_LABEL_ERROR_CORRECTION_LEVEL8           = 8,
};

//typedef NS_ENUM(NSInteger, MPOS_LABEL_BARCODE_ORIGIN_POINT) {
//    MPOS_LABEL_BARCODE_ORIGIN_POINT_CENTER     = 0,
//    MPOS_LABEL_BARCODE_ORIGIN_POINT_UPPER      = 1,
//};

typedef NS_ENUM(NSInteger, MPOS_LABEL_PDF417_ORIGIN_POINT) {
    LABEL_PDF417_ORIGIN_POINT_CENTER        = 0,
    LABEL_PDF417_ORIGIN_POINT_UPPER_LEFT    = 1,
};
    
typedef NS_ENUM(NSInteger, MPOS_LABEL_PDF417_COMPRESSION_METHOD) {
    MPOS_LABEL_PDF417_DATA_COMPRESSION_TEXT         = 0,
    MPOS_LABEL_PDF417_DATA_COMPRESSION_NUMERIC      = 1,
    MPOS_LABEL_PDF417_DATA_COMPRESSION_BINARY       = 2,
    LABEL_PDF417_DATA_COMPRESSION_TEXT              = 0,
    LABEL_PDF417_DATA_COMPRESSION_NUMERIC           = 1,
    LABEL_PDF417_DATA_COMPRESSION_BINARY            = 2,
};

typedef NS_ENUM(char, MPOS_LABEL_QRCODE_ECC_LEVEL){
    MPOS_LABEL_QRCODE_ECCL_EVEL_L   = 'L',
    MPOS_LABEL_QRCODE_ECCL_EVEL_M   = 'M',
    MPOS_LABEL_QRCODE_ECCL_EVEL_Q   = 'Q',
    MPOS_LABEL_QRCODE_ECCL_EVEL_H   = 'H',
    LABEL_QRCODE_ECC_L              = 'L',
    LABEL_QRCODE_ECC_M              = 'M',
    LABEL_QRCODE_ECC_Q              = 'Q',
    LABEL_QRCODE_ECC_H              = 'H',
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_QRCODE_MODE) {
    MPOS_LABEL_QRCODE_MODEL_1       = 1,
    MPOS_LABEL_QRCODE_MODEL_2       = 2,
    LABEL_QRCODE_MODEL_1            = 1,
    LABEL_QRCODE_MODEL_2            = 2,
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_STARTING_MODE) {
    MPOS_LABEL_STARTINGMODE_REGULAR_ALPHANUMERIC        = 0,
    MPOS_LABEL_STARTINGMODE_MULTIPLE_READ_ALPHANUMERIC  = 1,
    MPOS_LABEL_STARTINGMODE_REGULAR_NUMERIC             = 2,
    MPOS_LABEL_STARTINGMODE_GROUP_ALPHANUMERIC          = 3,
    MPOS_LABEL_STARTINGMODE_REGULAR_ALPHANUMRIC_SHIFT1  = 4,
    MPOS_LABEL_STARTINGMODE_REGULAR_ALPHANUMRIC_SHIFT2  = 5,
    MPOS_LABEL_STARTINGMODE_AUTOMATIC                   = 7,
    LABEL_REGULAR_ALPHANUMERIC                          = 0,
    LABEL_MULTIPLE_READ_ALPHANUMERIC                    = 1,
    LABEL_REGULAR_NUMERIC                               = 2,
    LABEL_GROUP_ALPHANUMERIC                            = 3,
    LABEL_REGULAR_ALPHANUMRIC_SHIFT1                    = 4,
    LABEL_REGULAR_ALPHANUMRIC_SHIFT2                    = 5,
    LABEL_AUTOMATIC                                     = 7,
    
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_CODABLACK_MODE) {
    MPOS_LABEL_CODABLOCK_MODE_A = 'A',
    MPOS_LABEL_CODABLOCK_MODE_E = 'E',
    MPOS_LABEL_CODABLOCK_MODE_F = 'F',
    LABEL_CODABLOCK_MODE_A = 'A',
    LABEL_CODABLOCK_MODE_E = 'E',
    LABEL_CODABLOCK_MODE_F = 'F',
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_CHECKDIGIT) {
    MPOS_LABEL_CHECKDIGIT_NONE                  = 0,
    MPOS_LABEL_CHECKDIGIT_1MOD10                = 1,
    MPOS_LABEL_CHECKDIGIT_2MOD10                = 2,
    MPOS_LABEL_CHECKDIGIT_1MOD11_AND_1MOD_10    = 3,
    LABEL_CHECKDIGIT_NONE                       = 0,
    LABEL_CHECKDIGIT_1MOD10                     = 1,
    LABEL_CHECKDIGIT_2MOD10                     = 2,
    LABEL_CHECKDIGIT_1MOD11_AND_1MOD_10         = 3,
    
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_RSS_BARCODE_TYPE) {
    MPOS_LABEL_RSS_BARCODE_TYPE_RSS14                = 0,
    MPOS_LABEL_RSS_BARCODE_TYPE_RSS14_TRUNCATED      = 1,
    MPOS_LABEL_RSS_BARCODE_TYPE_RSS14_STACKED        = 2,
    MPOS_LABEL_RSS_BARCODE_TYPE_RSS14_STACKED_OMNIDIRECTIONAL = 3,
    MPOS_LABEL_RSS_BARCODE_TYPE_RSS_LIMITED          = 4,
    MPOS_LABEL_RSS_BARCODE_TYPE_RSS_EXPANDED         = 5,
    MPOS_LABEL_RSS_BARCODE_TYPE_UPC_A                = 6,
    MPOS_LABEL_RSS_BARCODE_TYPE_UPC_E                = 7,
    MPOS_LABEL_RSS_BARCODE_TYPE_EAN13                = 8,
    MPOS_LABEL_RSS_BARCODE_TYPE_EAN8                 = 9,
    MPOS_LABEL_RSS_BARCODE_TYPE_UCC_EAN128_CC_A_B    = 10,
    MPOS_LABEL_RSS_BARCODE_TYPE_UCC_EAN128_CC_C      = 11,
    LABEL_RSS14                     = 0,
    LABEL_RSS14_TRUNCATED           = 1,
    LABEL_RSS14_STACKED             = 2,
    LABEL_RSS14_STACKED_OMNI        = 3,
    LABEL_RSS_LIMITED               = 4,
    LABEL_RSS_EXPANDED              = 5,
    LABEL_RSS_UPC_A                 = 6,
    LABEL_RSS_UPC_E                 = 7,
    LABEL_RSS_EAN13                 = 8,
    LABEL_RSS_EAN8                  = 9,
    LABEL_RSS_UCC_EAN128_CC_A_B     = 10,
    LABEL_RSS_UCC_EAN128_CC_C       = 11,
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_ROTATION_DEGREES){
    MPOS_LABEL_ROTATION_DEGREES_0           = 0,
    MPOS_LABEL_ROTATION_DEGREES_90          = 1,
    MPOS_LABEL_ROTATION_DEGREES_180         = 2,
    MPOS_LABEL_ROTATION_DEGREES_270         = 3,
    LABEL_ROTATION_DEGREES_0                = 0,
    LABEL_ROTATION_DEGREES_90               = 1,
    LABEL_ROTATION_DEGREES_180              = 2,
    LABEL_ROTATION_DEGREES_270              = 3,
};

typedef NS_ENUM(char, MPOS_LABEL_DEVICE_FONT){
    MPOS_LABEL_DEVICE_FONT_6PT                   ='0',         //    9 X 15 (dots)
    MPOS_LABEL_DEVICE_FONT_8PT                   ='1',         //   12 X 20 (dots)
    MPOS_LABEL_DEVICE_FONT_10PT                  ='2',         //   16 X 25 (dots)
    MPOS_LABEL_DEVICE_FONT_12PT                  ='3',         //   19 X 30 (dots)
    MPOS_LABEL_DEVICE_FONT_15PT                  ='4',         //   24 X 38 (dots)
    MPOS_LABEL_DEVICE_FONT_20PT                  ='5',         //   32 X 40 (dots)
    MPOS_LABEL_DEVICE_FONT_30PT                  ='6',         //   48 X 76 (dots)
    MPOS_LABEL_DEVICE_FONT_14PT                  ='7',         //   22 X 34 (dots)
    MPOS_LABEL_DEVICE_FONT_18PT                  ='8',         //   28 X 44 (dots)
    MPOS_LABEL_DEVICE_FONT_24PT                  ='9',         //   37 X 58 (dots)
    MPOS_LABEL_DEVICE_FONT_KOREAN1               ='a',         //   16 X 16 (dots)  (ascii  9 X 15)
    MPOS_LABEL_DEVICE_FONT_KOREAN2               ='b',         //   24 X 24 (dots)  (ascii 12 X 24)
    MPOS_LABEL_DEVICE_FONT_KOREAN3               ='c',         //   20 X 20 (dots)  (ascii 12 X 20)
    MPOS_LABEL_DEVICE_FONT_KOREAN4               ='d',         //   26 X 26 (dots)  (ascii 16 X 30)
    MPOS_LABEL_DEVICE_FONT_KOREAN5               ='e',         //   20 X 26 (dots)  (ascii 16 X 30)
    MPOS_LABEL_DEVICE_FONT_KOREAN6               ='f',         //   38 X 38 (dots)  (ascii 22 X 34)
    MPOS_LABEL_DEVICE_FONT_GB2312                ='m',         //   24 X 24 (dots)  (ascii 12 X 24)
    MPOS_LABEL_DEVICE_FONT_BIG5                  ='n',         //   24 X 24 (dots)  (ascii 12 X 24)
    MPOS_LABEL_DEVICE_FONT_SHIFT_JIS             ='j',         //   24 X 24 (dots)  (ascii 12 X 24)
    LABEL_DEVICE_FONT_6PT                       ='0',         //    9 X 15 (dots)
    LABEL_DEVICE_FONT_8PT                       ='1',         //   12 X 20 (dots)
    LABEL_DEVICE_FONT_10PT                      ='2',         //   16 X 25 (dots)
    LABEL_DEVICE_FONT_12PT                      ='3',         //   19 X 30 (dots)
    LABEL_DEVICE_FONT_15PT                      ='4',         //   24 X 38 (dots)
    LABEL_DEVICE_FONT_20PT                      ='5',         //   32 X 40 (dots)
    LABEL_DEVICE_FONT_30PT                      ='6',         //   48 X 76 (dots)
    LABEL_DEVICE_FONT_14PT                      ='7',         //   22 X 34 (dots)
    LABEL_DEVICE_FONT_18PT                      ='8',         //   28 X 44 (dots)
    LABEL_DEVICE_FONT_24PT                      ='9',         //   37 X 58 (dots)
    LABEL_DEVICE_FONT_KOREAN1                   ='a',         //   16 X 16 (dots)  (ascii  9 X 15)
    LABEL_DEVICE_FONT_KOREAN2                   ='b',         //   24 X 24 (dots)  (ascii 12 X 24)
    LABEL_DEVICE_FONT_KOREAN3                   ='c',         //   20 X 20 (dots)  (ascii 12 X 20)
    LABEL_DEVICE_FONT_KOREAN4                   ='d',         //   26 X 26 (dots)  (ascii 16 X 30)
    LABEL_DEVICE_FONT_KOREAN5                   ='e',         //   20 X 26 (dots)  (ascii 16 X 30)
    LABEL_DEVICE_FONT_KOREAN6                   ='f',         //   38 X 38 (dots)  (ascii 22 X 34)
    LABEL_DEVICE_FONT_GB2312                    ='m',         //   24 X 24 (dots)  (ascii 12 X 24)
    LABEL_DEVICE_FONT_BIG5                      ='n',         //   24 X 24 (dots)  (ascii 12 X 24)
    LABEL_DEVICE_FONT_SHIFT_JIS                 ='j',         //   24 X 24 (dots)  (ascii 12 X 24)
};

typedef NS_ENUM (NSInteger, MPOS_LABEL_DRAW_CIRCLE_SIZE){
    MPOS_LABEL_DRAW_CIRCLE_SIZE_40X40             = 1,
    MPOS_LABEL_DRAW_CIRCLE_SIZE_56X56             = 2,
    MPOS_LABEL_DRAW_CIRCLE_SIZE_72X72             = 3,
    MPOS_LABEL_DRAW_CIRCLE_SIZE_88X88             = 4,
    MPOS_LABEL_DRAW_CIRCLE_SIZE_104X104           = 5,
    MPOS_LABEL_DRAW_CIRCLE_SIZE_168X168           = 6,
};

typedef  NS_ENUM (NSInteger, MPOS_LABEL_CONFIG_ICS){
    MPOS_LABEL_CONFIG_ICS_USA                   = 0,
    MPOS_LABEL_CONFIG_ICS_FRANCE                = 1,
    MPOS_LABEL_CONFIG_ICS_GERMANY               = 2,
    MPOS_LABEL_CONFIG_ICS_UK                    = 3,
    MPOS_LABEL_CONFIG_ICS_DENMARK_I             = 4,
    MPOS_LABEL_CONFIG_ICS_SWEDEN                = 5,
    MPOS_LABEL_CONFIG_ICS_ITALY                 = 6,
    MPOS_LABEL_CONFIG_ICS_SPAIN_I               = 7,
    MPOS_LABEL_CONFIG_ICS_NORWAY                = 8,
    MPOS_LABEL_CONFIG_ICS_DENMARK_II            = 9,
    MPOS_LABEL_CONFIG_ICS_JAPAN                 = 10,
    MPOS_LABEL_CONFIG_ICS_SPAIN_II              = 11,
    MPOS_LABEL_CONFIG_ICS_LATIN_AMERICA         = 12,
    MPOS_LABEL_CONFIG_ICS_KOREA                 = 13,
    MPOS_LABEL_CONFIG_ICS_SLOVENIA_CROATIA      = 14,
    MPOS_LABEL_CONFIG_ICS_CHINA                 = 15,
    LABEL_ICS_USA                               = 0,
    LABEL_ICS_FRANCE                            = 1,
    LABEL_ICS_GERMANY                           = 2,
    LABEL_ICS_UK                                = 3,
    LABEL_ICS_DENMARK_I                         = 4,
    LABEL_ICS_SWEDEN                            = 5,
    LABEL_ICS_ITALY                             = 6,
    LABEL_ICS_SPAIN_I                           = 7,
    LABEL_ICS_NORWAY                            = 8,
    LABEL_ICS_DENMARK_II                        = 9,
    LABEL_ICS_JAPAN                             = 10,
    LABEL_ICS_SPAIN_II                          = 11,
    LABEL_ICS_LATIN_AMERICA                     = 12,
    LABEL_ICS_KOREA                             = 13,
    LABEL_ICS_SLOVENIA_CROATIA                  = 14,
    LABEL_ICS_CHINA                             = 15,
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_CONFIG_CODEPAGE){
    MPOS_LABEL_CONFIG_CODEPAGE_CP437            = 0,
    MPOS_LABEL_CONFIG_CODEPAGE_CP850            = 1,
    MPOS_LABEL_CONFIG_CODEPAGE_CP852            = 2,
    MPOS_LABEL_CONFIG_CODEPAGE_CP860            = 3,
    MPOS_LABEL_CONFIG_CODEPAGE_CP863            = 4,
    MPOS_LABEL_CONFIG_CODEPAGE_CP865            = 5,
    MPOS_LABEL_CONFIG_CODEPAGE_CP1252           = 6,
    MPOS_LABEL_CONFIG_CODEPAGE_CP865_WCP1252    = 7,
    MPOS_LABEL_CONFIG_CODEPAGE_CP857            = 8,
    MPOS_LABEL_CONFIG_CODEPAGE_CP737            = 9,
    MPOS_LABEL_CONFIG_CODEPAGE_WPC1250          = 10,
    MPOS_LABEL_CONFIG_CODEPAGE_WPC1253          = 11,
    MPOS_LABEL_CONFIG_CODEPAGE_WPC1254          = 12,
    MPOS_LABEL_CONFIG_CODEPAGE_CP855            = 13,
    MPOS_LABEL_CONFIG_CODEPAGE_CP862            = 14,
    MPOS_LABEL_CONFIG_CODEPAGE_CP866            = 15,
    MPOS_LABEL_CONFIG_CODEPAGE_WCP1251          = 16,
    MPOS_LABEL_CONFIG_CODEPAGE_WCP1255          = 17,
    MPOS_LABEL_CONFIG_CODEPAGE_CP928            = 18,
    MPOS_LABEL_CONFIG_CODEPAGE_CP864            = 19,
    MPOS_LABEL_CONFIG_CODEPAGE_CP775            = 20,
    MPOS_LABEL_CONFIG_CODEPAGE_WCP1257          = 21,
    MPOS_LABEL_CONFIG_CODEPAGE_CP858            = 22,
    LABEL_CODEPAGE_CP437                        = 0,
    LABEL_CODEPAGE_CP850                        = 1,
    LABEL_CODEPAGE_CP852                        = 2,
    LABEL_CODEPAGE_CP860                        = 3,
    LABEL_CODEPAGE_CP863                        = 4,
    LABEL_CODEPAGE_CP865                        = 5,
    LABEL_CODEPAGE_CP1252                       = 6,
    LABEL_CODEPAGE_CP865_WCP1252                = 7,
    LABEL_CODEPAGE_CP857                        = 8,
    LABEL_CODEPAGE_CP737                        = 9,
    LABEL_CODEPAGE_WPC1250                      = 10,
    LABEL_CODEPAGE_WPC1253                      = 11,
    LABEL_CODEPAGE_WPC1254                      = 12,
    LABEL_CODEPAGE_CP855                        = 13,
    LABEL_CODEPAGE_CP862                        = 14,
    LABEL_CODEPAGE_CP866                        = 15,
    LABEL_CODEPAGE_WCP1251                      = 16,
    LABEL_CODEPAGE_WCP1255                      = 17,
    LABEL_CODEPAGE_CP928                        = 18,
    LABEL_CODEPAGE_CP864                        = 19,
    LABEL_CODEPAGE_CP775                        = 20,
    LABEL_CODEPAGE_WCP1257                      = 21,
    LABEL_CODEPAGE_CP858                        = 22
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_STATUS) {
    MPOS_LABEL_STATUS_IDLE                                      = 0,
    MPOS_LABEL_STATUS_PRINTER_PAPEREMPTY                        = 1,
    MPOS_LABEL_STATUS_PRINTER_COVEROPEN                         = 2,
    MPOS_LABEL_STATUS_PRINTER_CUTTER_JAMMED                     = 4,
    MPOS_LABEL_STATUS_PRINTER_TPH_OVERHEAT                      = 8,
    MPOS_LABEL_STATUS_PRINTER_GAP_ERROR                         = 16,
    MPOS_LABEL_STATUS_PRINTER_RIBBON_END                        = 32,
    MPOS_LABEL_STATUS_PRINTER_ON_BUILDING_LABEL_TO_BE_PRINTED   = 64,
    MPOS_LABEL_STATUS_PRINTER_ON_PRINTING_LABEL                 = 128,
    MPOS_LABEL_STATUS_PRINTER_ISSUED_LABEL_ISPAUSED             = 256,
    MPOS_LABEL_STATUS_PRINTER_MOTOR_OVERHEAT                    = 512,
    MPOS_LABEL_STATUS_PRINTER_BOARD_OVERHEAT                    = 1024,
    MPOS_LABEL_STATUS_PRINTER_WAIT_PAPER_TAKEN                  = 2048,
    MPOS_LABEL_STATUS_PRINTER_RFID_WRITING_ERROR                = 4096,
    LABEL_STATUS_IDLE                                           = 0,
    LABEL_STATUS_PAPEREMPTY                                     = 1,
    LABEL_STATUS_COVEROPEN                                      = 2,
    LABEL_STATUS_CUTTER_JAMMED                                  = 4,
    LABEL_STATUS_TPH_OVERHEAT                                   = 8,
    LABEL_STATUS_GAP_ERROR                                      = 16,
    LABEL_STATUS_RIBBON_END                                     = 32,
    LABEL_STATUS_ON_BUILDING_LABEL                              = 64,
    LABEL_STATUS_ON_PRINTING_LABEL                              = 128,
    LABEL_STATUS_ISSUED_LABEL_PAUSED                            = 256,
    LABEL_STATUS_MOTOR_OVERHEAT                                 = 512,
    LABEL_STATUS_BOARD_OVERHEAT                                 = 1024,
    LABEL_STATUS_WAIT_LABEL_TAKEN                               = 2048,
    LABEL_STATUS_RFID_WRITING_ERROR                             = 4096
    
};

typedef NS_ENUM(char, MPOS_LABEL_VECTOR_FONT){
    MPOS_LABEL_VECTOR_FONT_ASCII                    = 'U',
    MPOS_LABEL_VECTOR_FONT_KS5601                   = 'K',
    MPOS_LABEL_VECTOR_FONT_BIG5                     = 'B',
    MPOS_LABEL_VECTOR_FONT_GB2312                   = 'G',
    MPOS_LABEL_VECTOR_FONT_SHIFT_JIS                = 'J',
    MPOS_LABEL_VECTOR_FONT_OCR_A                    = 'a',
    MPOS_LABEL_VECTOR_FONT_OCR_B                    = 'b',
    LABEL_VECTOR_FONT_ASCII                         = 'U',
    LABEL_VECTOR_FONT_KS5601                        = 'K',
    LABEL_VECTOR_FONT_BIG5                          = 'B',
    LABEL_VECTOR_FONT_GB2312                        = 'G',
    LABEL_VECTOR_FONT_SHIFT_JIS                     = 'J',
    LABEL_VECTOR_FONT_OCR_A                         = 'a',
    LABEL_VECTOR_FONT_OCR_B                         = 'b',
};

typedef NS_ENUM(char, MPOS_LABEL_DRAW_BLOCK_OPTION){
    MPOS_LABEL_DRAW_BLOCK_OPTION_LINE_OVERWRITING   ='O',
    MPOS_LABEL_DRAW_BLOCK_OPTION_LINE_EXCLUSIVE_OR  ='E',
    MPOS_LABEL_DRAW_BLOCK_OPTION_LINE_DELETE        ='D',
    MPOS_LABEL_DRAW_BLOCK_OPTION_SLOPE              ='S',
    MPOS_LABEL_DRAW_BLOCK_OPTION_BOX                ='B',
    LABEL_LINE_OVERWRITING                          ='O',
    LABEL_LINE_EXCLUSIVE_OR                         ='E',
    LABEL_LINE_DELETE                               ='D',
    LABEL_SLOPE                                     ='S',
    LABEL_BOX                                       ='B',
};

typedef NS_ENUM(char, MPOS_LABEL_PRINTING_TYPE) {
    MPOS_LABEL_PRINTING_TYPE_DIRECT_THERMAL         = 'd',
    MPOS_LABEL_PRINTING_TYPE_THERMAL_TRANSFER       = 't',
    LABEL_DIRECT_THERMAL                            = 'd',
    LABEL_THERMAL_TRANSFER                          = 't',
};

typedef NS_ENUM(char, MPOS_LABEL_MEDIA_TYPE) {
    MPOS_LABEL_MEDIA_TYPE_GAP           = 'G',
    MPOS_LABEL_MEDIA_TYPE_CONTINUOUS    = 'C',
    MPOS_LABEL_MEDIA_TYPE_BLACK_MARK    = 'B',
    LABEL_MEDIA_TYPE_GAP                = 'G',
    LABEL_MEDIA_TYPE_CONTINUOUS         = 'C',
    LABEL_MEDIA_TYPE_BLACK_MARK         = 'B',
};

typedef NS_ENUM(char, MPOS_LABEL_PRINTING_DIRECTION) {
    MPOS_LABEL_PRINTING_DIRECTION_TOP_TO_BOTTOM   = 'T',
    MPOS_LABEL_PRINTING_DIRECTION_BOTTOM_TO_TOP   = 'B',
    LABEL_ORIENTATION_TOP                         = 'T',
    LABEL_ORIENTATION_BOTTOM                      = 'B',
};

//typedef NS_ENUM(NSInteger, MPOS_LABEL_SPEED_VALUE) {
//    MPOS_LABEL_SPEED_VALUE_2_5_IPS               = 0,
//    MPOS_LABEL_SPEED_VALUE_3_0_IPS               = 1,
//    MPOS_LABEL_SPEED_VALUE_4_0_IPS               = 2,
//    MPOS_LABEL_SPEED_VALUE_5_0_IPS               = 3,
//    MPOS_LABEL_SPEED_VALUE_6_0_IPS               = 4,
//    MPOS_LABEL_SPEED_VALUE_7_0_IPS               = 5,
//    MPOS_LABEL_SPEED_VALUE_8_0_IPS               = 6,
//};

typedef NS_ENUM(NSInteger, MPOS_LABEL_RFID_TRANSPONDER_TYPE) {
    MPOS_LABEL_RFID_TRANSPONDER_TYPE_NONE                   = 0,
    MPOS_LABEL_RFID_TRANSPONDER_TYPE_ISO_18000_6_TYPE_A     = 1,
    MPOS_LABEL_RFID_TRANSPONDER_TYPE_ISO_18000_6_TYPE_B     = 2,
    MPOS_LABEL_RFID_TRANSPONDER_TYPE_EPC_CLASS_0            = 3,
    MPOS_LABEL_RFID_TRANSPONDER_TYPE_EPC_CLASS_1            = 4,
    MPOS_LABEL_RFID_TRANSPONDER_TYPE_EPC_CLASS_1_GEN2       = 5,
    LABEL_RFID_NONE                                         = 0,
    LABEL_RFID_ISO_TYPE_A                                   = 1,
    LABEL_RFID_ISO_TYPE_B                                   = 2,
    LABEL_RFID_EPC_0                                        = 3,
    LABEL_RFID_EPC_1                                        = 4,
    LABEL_RFID_EPC_GEN2                                     = 5,
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_RFID_DATA_TYPE) {
    MPOS_LABEL_RFID_DATA_TYPE_ASCII     = 'A',
    MPOS_LABEL_RFID_DATA_TYPE_HEX       = 'H',
    MPOS_LABEL_RFID_DATA_TYPE_EPC       = 'E',
    MPOS_LABEL_RFID_DATA_TYPE_USER_HEX  = 'U',
    LABEL_RFID_DATA_TYPE_ASCII          = 'A',
    LABEL_RFID_DATA_TYPE_HEX            = 'H',
    LABEL_RFID_DATA_TYPE_EPC            = 'E',
    LABEL_RFID_DATA_TYPE_USER_HEX       = 'U'
};

typedef NS_ENUM(NSInteger, MPOS_LABEL_STATISTICS) {
    LABEL_STATS_MOTOR1  = 0,
    LABEL_STATS_MOTOR2  = 1,
    LABEL_STATS_TPH1    = 2,
    LABEL_STATS_TPH2    = 3,
    LABEL_STATS_CUT1    = 4,
    LABEL_STATS_CUT2    = 5,
};

typedef NS_ENUM(NSInteger, MPOS_TRANSACTION) {
    MPOS_TRANSACTION_OUT    = 0,
    MPOS_TRANSACTION_IN     = 1
};

typedef NS_ENUM(NSInteger, MPOS_PRINTER_PAGEMODE) {
    MPOS_PRINTER_PAGEMODE_OUT   = 0,
    MPOS_PRINTER_PAGEMODE_IN    = 1,
    POS_PAGEMODE_OUT            = 0,
    POS_PAGEMODE_IN             = 1
};

typedef NS_ENUM(NSInteger, MPOS_PRINTER_PD) {
    MPOS_PRINTER_PD_0           = 0,
    MPOS_PRINTER_PD_LEFT90      = 1,
    MPOS_PRINTER_PD_180         = 2,
    MPOS_PRINTER_PD_RIGHT90     = 3,
    POS_DIRECTION_0             = 0,
    POS_DIRECTION_LEFT90        = 1,
    POS_DIRECTION_180           = 2,
    POS_DIRECTION_RIGHT90       = 3
};

typedef NS_ENUM(NSInteger, MPOS_READMODE) {
    MPOS_READMODE_ALWAYS   = 0,
    MPOS_READMODE_ONCE     = 1,
    MPOS_READMODE_NONE     = 2
};

typedef NS_ENUM(NSInteger, MPOS_STATUS) {
    MPOS_STATUS_NORMAL                  = 0,
    POS_STATUS_NORMAL                   = 0,
    MPOS_STATUS_PRINTER_COVEROPEN       = 1,
    POS_STATUS_COVEROPEN                = 1,
    MPOS_STATUS_PRINTER_PAPEREMPTY      = 2,
    POS_STATUS_PAPEREMPTY               = 2,
    
    MPOS_STATUS_PRINTER_NEAREND         = 4,
    POS_STATUS_PAPER_NEAREND            = 4,
    
    MPOS_STATUS_PRINTER_ERROR           = 8,
    POS_STATUS_ERROR                    = 8,
    
    MPOS_STATUS_BATT_HIGH               = 16,
    POS_STATUS_BATT_HIGH                = 16,
    MPOS_STATUS_BATT_MID                = 32,
    POS_STATUS_BATT_MID                 = 32,
    MPOS_STATUS_BATT_LOW                = 64,
    POS_STATUS_BATT_LOW                 = 64,
    
    MPOS_STATUS_PRINTER_OFFLINE         = 128,
    POS_STATUS_OFFLINE                  = 128,
    
    MPOS_STATUS_DRAWER_HIGH             = 256,
    POS_STATUS_DRAWER_HIGH              = 256,
    MPOS_STATUS_DRAWER_LOW              = 512,
    POS_STATUS_DRAWER_LOW               = 512,
    
    MPOS_STATUS_BGT_BUSY                = 1200,
    MPOS_STATUS_BGT_PROGRESS            = 1201,
    MPOS_STATUS_BGT_COMPLETED           = 1202,
    MPOS_STATUS_BGT_REQUIRE_RESET       = 1203,
    MPOS_STATUS_FAIL                    = -1
};

typedef NS_ENUM(NSInteger, POS_IMAGE_COMPRESS) {
    POS_IMAGE_COMPRESS_NONE = 0,
    POS_IMAGE_COMPRESS_RLE  = 1,
    POS_IMAGE_COMPRESS_LZMA = 2,
    POS_IMAGE_NONE          = 0,
    POS_IMAGE_RLE           = 1,
    POS_IMAGE_LZMA          = 2,
};

typedef NS_ENUM(NSInteger, LABEL_IMAGE_COMPRESS) {
    LABEL_IMAGE_NONE    = 0,
    LABEL_IMAGE_RLE     = 1,
    LABEL_IMAGE_LZMA    = 2
};

typedef struct{
    NSInteger codepage;
    MPOS_FONT_TYPE fontType;
    MPOS_FONT_SIZE_WIDTH width;
    MPOS_FONT_SIZE_HEIGHT height;
    MPOS_FONT_UNDERLINE underLine;
    MPOS_ALIGNMENT alignment;
    BOOL bold;
    BOOL reverse;
    BOOL color;
}  MPOS_FONT_ATTRIBUTES;



