
class PrinterLabelInfo {
  int labelWidth = 52;
  int labelHeight = 75;
  int cutEnable = 0;
  int dpi = 203;
  int orientation = PrintOrientation.toptobttom.convertedInteger;
  int mediaType = LabelMediaType.gap.convertedInteger;
  static PrinterLabelInfo fromJON(Map<String, dynamic> json) {
    var printerLabelInfo = PrinterLabelInfo();
    printerLabelInfo.labelWidth = json['label_width'];
    printerLabelInfo.labelHeight = json['label_height'];
    printerLabelInfo.cutEnable = json['cut_enable'];
    printerLabelInfo.mediaType = json['media_type'];
    printerLabelInfo.orientation = json['orientation'];
    return printerLabelInfo;
  }
}

// Orientation
enum PrintOrientation {
  toptobttom, bottomtotop
}

extension PrintOrientationExtension on PrintOrientation {
  int get convertedInteger {
    switch(this){
      case PrintOrientation.toptobttom: return 0;
      case PrintOrientation.bottomtotop: return 1;
      default: return 0;
    }
  }

  String get convertedText {
    switch(this){
      case PrintOrientation.toptobttom: return 'T';
      case PrintOrientation.bottomtotop: return 'B';
      default: return '';
    }
  }
}

// Media Type
enum LabelMediaType {
  gap, blackmark, continuous
}

extension LabelMediaTypeExtension on LabelMediaType {
  int get convertedInteger {
    switch(this){
      case LabelMediaType.gap: return 0;
      case LabelMediaType.blackmark: return 1;
      case LabelMediaType.continuous: return 2;
      default: return 0;
    }
  }

  String get convertedText {
    switch(this){
      case LabelMediaType.gap: return 'G';
      case LabelMediaType.blackmark: return 'B';
      case LabelMediaType.continuous: return 'C';
      default: return '';
    }
  }
}
