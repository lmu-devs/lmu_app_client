import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

abstract class BaseTile extends StatelessWidget {
  const BaseTile({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final CrossAxisAlignment crossAxisAlignment;
  Widget buildTile(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(LmuSizes.size_4),
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.tile,
        borderRadius: BorderRadius.circular(
          LmuSizes.size_8,
        ),
      ),
      child: buildTile(context),
    );
  }
}

class LmuContentTile extends BaseTile {
  const LmuContentTile({
    required this.content,
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(LmuSizes.size_8)),
    this.isTop = false,
    this.isMiddle = false,
    super.crossAxisAlignment = CrossAxisAlignment.start,
  });

  factory LmuContentTile.top({
    required List<Widget> content,
    Key? key,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) =>
      LmuContentTile(
        content: content,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(LmuSizes.size_8),
        ),
        isTop: true,
        key: key,
        crossAxisAlignment: crossAxisAlignment,
      );

  factory LmuContentTile.middle({
    required List<Widget> content,
    Key? key,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) =>
      LmuContentTile(
        content: content,
        borderRadius: BorderRadius.zero,
        isMiddle: true,
        key: key,
        crossAxisAlignment: crossAxisAlignment,
      );

  factory LmuContentTile.bottom({
    required List<Widget> content,
    Key? key,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) =>
      LmuContentTile(
        content: content,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(LmuSizes.size_8),
        ),
        key: key,
        crossAxisAlignment: crossAxisAlignment,
      );

  final List<Widget> content;
  final BorderRadius borderRadius;
  final bool isTop;
  final bool isMiddle;

  @override
  Widget buildTile(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(LmuSizes.size_4),
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.tile,
        borderRadius: borderRadius,
        border: _getBorder(context),
      ),
      child: buildTile(context),
    );
  }

  Border? _getBorder(BuildContext context) {
    if (!isTop && !isMiddle) return null;

    return Border(
      bottom: BorderSide(
        color: context.colors.neutralColors.borderColors.seperatorLight,
        width: .5,
      ),
    );
  }
}
