import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';

class ScreeningPlaceholder extends StatelessWidget {
  const ScreeningPlaceholder({
    super.key,
    required this.minHeight,
  });

  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return PlaceholderTile(
      minHeight: minHeight,
      content: [
        LmuText.body(
          context.locals.cinema.nextMovieEmpty,
          color: context.colors.neutralColors.textColors.mediumColors.base,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
