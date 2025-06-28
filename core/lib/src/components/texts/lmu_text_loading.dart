import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../components.dart';

class LmuTextLoading extends StatelessWidget {
  factory LmuTextLoading.body({
    required int charNo,
  }) =>
      LmuTextLoading(text: LmuText.body(BoneMock.chars(charNo)));

  factory LmuTextLoading.h2({
    required int charNo,
  }) =>
      LmuTextLoading(text: LmuText.h2(BoneMock.chars(charNo)));

  factory LmuTextLoading.h3({
    required int charNo,
  }) =>
      LmuTextLoading(text: LmuText.h3(BoneMock.chars(charNo)));
  const LmuTextLoading({
    super.key,
    required this.text,
  });

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(child: text);
  }
}
