enum SheetSizes {
  small,
  medium,
  large,
}

extension SheetSizesExtension on SheetSizes {
  double get size {
    switch (this) {
      case SheetSizes.small:
        return 0.11;
      case SheetSizes.medium:
        return 0.3;
      case SheetSizes.large:
        return 0.9;
    }
  }
}
