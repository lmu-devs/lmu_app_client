import 'package:barcode_widget/barcode_widget.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class SportsTicketCard extends StatelessWidget {
  const SportsTicketCard({
    super.key,
    required this.data,
    required this.name,
    required this.courseName,
    required this.timeSlot,
    required this.validTimeFrame,
    required this.uniId,
    required this.id,
  });

  final String data;
  final String name;
  final String courseName;
  final String timeSlot;
  final String validTimeFrame;
  final String uniId;
  final String id;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.neutralColors.backgroundColors.tile,
        borderRadius: BorderRadius.circular(LmuSizes.size_12),
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LmuText.body("Angebot",
                                  weight: FontWeight.w600, color: colors.neutralColors.textColors.weakColors.base),
                              LmuText.body(courseName, weight: FontWeight.w600),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LmuText.body("Name",
                                  weight: FontWeight.w600, color: colors.neutralColors.textColors.weakColors.base),
                              LmuText.body(name, weight: FontWeight.w600),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: LmuSizes.size_8),
                    Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (timeSlot.isNotEmpty)
                                LmuText.body("Zeit",
                                    weight: FontWeight.w600, color: colors.neutralColors.textColors.weakColors.base),
                              LmuText.body(timeSlot, weight: FontWeight.w600),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LmuText.body("Gültig",
                                  weight: FontWeight.w600, color: colors.neutralColors.textColors.weakColors.base),
                              LmuText.body(validTimeFrame, weight: FontWeight.w600),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: LmuSizes.size_8),
                    Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LmuText.body("Uni",
                                  weight: FontWeight.w600, color: colors.neutralColors.textColors.weakColors.base),
                              LmuText.body(uniId, weight: FontWeight.w600),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LmuText.body("ID",
                                  weight: FontWeight.w600, color: colors.neutralColors.textColors.weakColors.base),
                              LmuText.body(id, weight: FontWeight.w600),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: LmuSizes.size_16,
                height: LmuSizes.size_32,
                decoration: BoxDecoration(
                  color: colors.neutralColors.backgroundColors.base,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(LmuSizes.size_16),
                    bottomRight: Radius.circular(LmuSizes.size_16),
                  ),
                ),
              ),
              Expanded(
                child: DashedLine(
                  color: colors.neutralColors.textColors.mediumColors.disabled!,
                  height: 1.5,
                ),
              ),
              Container(
                width: LmuSizes.size_16,
                height: LmuSizes.size_32,
                decoration: BoxDecoration(
                  color: colors.neutralColors.backgroundColors.base,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(LmuSizes.size_16),
                    bottomLeft: Radius.circular(LmuSizes.size_16),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: BarcodeWidget(
              color: colors.neutralColors.textColors.strongColors.base,
              height: LmuSizes.size_72,
              barcode: Barcode.code128(),
              data: data,
              drawText: false,
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  const DashedLine({super.key, this.height = 1, this.color = Colors.black});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
