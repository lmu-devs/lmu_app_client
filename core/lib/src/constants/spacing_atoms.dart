class SpacingAtoms {
  const SpacingAtoms({
    required this.tilePadding,
    required this.tileItemPaddingHorizontal,
    required this.tileItemPaddingVertical,
    required this.devicePaddings,
    required this.gaps,
    required this.visualSizes,
  });

  final double tilePadding;
  final double tileItemPaddingHorizontal;
  final double tileItemPaddingVertical;
  final DevicePaddings devicePaddings;
  final Gaps gaps;
  final VisualSizes visualSizes;
}

class DevicePaddings {
  const DevicePaddings({
    required this.horizontal,
    required this.vertical,
  });

  final double horizontal;
  final double vertical;
}

class Gaps {
  const Gaps({
    required this.buttonSmall,
    required this.buttonMedium,
    required this.tabbarSmall,
    required this.tile,
  });

  final double buttonSmall;
  final double buttonMedium;
  final double tabbarSmall;
  final double tile;
}

class VisualSizes {
  const VisualSizes({
    required this.xxsmall,
    required this.xsmall,
    required this.small,
    required this.base,
  });

  final double xxsmall;
  final double xsmall;
  final double small;
  final double base;
}

class ClickableSizes {
  const ClickableSizes({
    required this.large,
    required this.base,
  });

  final double large;
  final double base;
}
