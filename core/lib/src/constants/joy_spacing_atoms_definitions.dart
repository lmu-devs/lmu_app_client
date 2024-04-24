import 'atom_primitives.dart';
import 'spacing_atoms.dart';

const spacingAtoms = SpacingAtoms(
  tilePadding: AtomPrimitives.size4,
  tileItemPaddingHorizontal: AtomPrimitives.size12,
  tileItemPaddingVertical: AtomPrimitives.size12,
  devicePaddings: DevicePaddings(
    horizontal: AtomPrimitives.size16Base,
    vertical: AtomPrimitives.size16Base,
  ),
  gaps: Gaps(
    buttonSmall: AtomPrimitives.size8,
    buttonMedium: AtomPrimitives.size16Base,
    tabbarSmall: AtomPrimitives.size4,
    tile: AtomPrimitives.size16Base,
  ),
  visualSizes: VisualSizes(
    xxsmall: AtomPrimitives.size20,
    xsmall: AtomPrimitives.size24,
    small: AtomPrimitives.size36,
    base: AtomPrimitives.size48,
  ),
);
