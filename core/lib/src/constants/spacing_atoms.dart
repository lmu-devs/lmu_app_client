import 'dart:ui';
import 'sizes.dart';

class SpacingAtoms {
  static const DevicePaddings devicePaddings = DevicePaddings();
  static const Gaps gaps = Gaps();

  static const double tileP = Sizes.size4;
  static const double tileItemPaddingHorizontal = Sizes.size4;
  static const double tileItemPaddingVertical = Sizes.size4;
}

class DevicePaddings {
  const DevicePaddings();
  static const double horizontal = Sizes.size16Base;
  static const double vertical = Sizes.size16Base;
  static const double bottom = Sizes.size48;
}

class Gaps {
  const Gaps();
  static const double tile = Sizes.size16Base;
  static const double buttonsSm = Sizes.size8;
  static const double buttonsM = Sizes.size16Base;
  static const double tabbarSm = Sizes.size4;
}
