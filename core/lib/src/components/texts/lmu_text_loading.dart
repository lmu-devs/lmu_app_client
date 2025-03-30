import 'package:core/components.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LmuTextLoading extends StatelessWidget {
  const LmuTextLoading({
    super.key,
    required this.text,
  });

  final Widget text;

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

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(child: text);
  }
}
