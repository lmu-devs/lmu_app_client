extension GradesFormattingExtension on double {
  String get asStringWithTwoDecimals {
    if (this < 1.0) {
      return "‒,––";
    }
    final rounded = (this * 100).round() / 100;
    return rounded.toStringAsFixed(2).replaceAll(".", ",");
  }

  String get asStringWithOneDecimal {
    if (this < 1.0) {
      return "‒,‒";
    }
    final rounded = (this * 10).round() / 10;
    return rounded.toStringAsFixed(1).replaceAll(".", ",");
  }
}
