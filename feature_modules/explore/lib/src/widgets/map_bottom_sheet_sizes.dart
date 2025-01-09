enum SheetSizes {
  small,
  medium,
  large,
}

extension SheetSizesExtension on SheetSizes {
  double get size {
    switch (this) {
      case SheetSizes.small:
        return 0; // 0.12;
      case SheetSizes.medium:
        return 0.25; // 0.31;
      case SheetSizes.large:
        return 0.9;
    }
  }
}
