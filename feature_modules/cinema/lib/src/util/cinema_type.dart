enum CinemaType {
  lmu,
  tum,
  tumGarching,
  hm,
}

extension CinemaTypeExtension on CinemaType {
  String getValue() {
    switch (this) {
      case CinemaType.lmu:
        return 'LMU';
      case CinemaType.tum:
        return 'TUM';
      case CinemaType.tumGarching:
        return 'TUM Garching';
      case CinemaType.hm:
        return 'HM';
    }
  }
}

extension CinemaTypeMapper on CinemaType {
  static CinemaType fromString(String type) {
    switch (type) {
      case "LMU":
        return CinemaType.lmu;
      case "TUM":
        return CinemaType.tum;
      case "TUM_GARCHING":
        return CinemaType.tumGarching;
      case "HM":
        return CinemaType.hm;
      default:
        throw ArgumentError("Invalid status: $type");
    }
  }
}
