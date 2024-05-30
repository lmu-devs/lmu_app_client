import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuBottomSheet {
  static void show(
    BuildContext context, {
    required String title,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      enableDrag: true,
      builder: (_) {
        return _LmuBottomSheetContent(
          title: title,
        );
      },
    );
  }
}

class _LmuBottomSheetContent extends StatelessWidget {
  const _LmuBottomSheetContent({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 1.0,
      expand: false,
      builder: (context, scrollController) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LmuHeader(
            title: title,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                LmuSizes.mediumLarge,
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LmuText.h1(
                      title,
                    ),
                    SizedBox(
                      height: LmuSizes.mediumSmall,
                    ),
                    LmuText.body(
                      "Adjust and activate your taste profile to filter dishes by your preferences and allergies.",
                    ),
                    SizedBox(
                      height: LmuSizes.xxlarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: LmuSizes.medium,
                      ),
                      child: LmuText.body(
                        "I eat",
                        color: context.colors.neutralColors.textColors.mediumColors.base,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(
                        LmuSizes.small,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.neutralColors.backgroundColors.tile,
                        borderRadius: BorderRadius.circular(
                          LmuSizes.medium,
                        ),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(
                              LmuSizes.medium,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: LmuSizes.mediumLarge,
                                  ),
                                  child: LmuIcon(
                                    size: LmuIconSizes.medium,
                                    icon: Icons.adb,
                                    color: context.colors.neutralColors.textColors.strongColors.base,
                                  ),
                                ),
                                LmuText.body(
                                  "Vegan",
                                ),
                                const Spacer(),
                                LmuIcon(
                                  size: LmuIconSizes.medium,
                                  icon: Icons.check,
                                  color: context.colors.neutralColors.textColors.strongColors.base,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: LmuSizes.xxxlarge,
                    ),
                    LmuText.bodyXSmall(
                      "Die Allergene und die übrigen Kennzeichnungen ändern sich möglicherweise durch kurzfristige Rezeptur- und Speiseplanänderungen, die nicht im Internetspeiseplan ersichtlich sein können. Bitte beachten Sie unbedingt die Angaben auf den tagesaktuellen Thekenaufstellern in der Betriebsstelle. Spurenhinweis für Allergiker: Spuren von Allergenen durch Kreuzkontaminationen während der Vor- und Zubereitung bzw. Ausgabe sowie durch technologisch unvermeidbare Verunreinigungen einzelner Zutaten können nicht ausgeschlossen werden und werden nicht gekennzeichnet.",
                      color: context.colors.neutralColors.textColors.weakColors.base,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LmuHeader extends StatelessWidget {
  const _LmuHeader({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        LmuSizes.mediumLarge,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: LmuText.h3(title),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: LmuSizes.mediumLarge,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: LmuIcon(
                        size: LmuIconSizes.medium,
                        icon: Icons.close,
                        color: context.colors.neutralColors.textColors.strongColors.base,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
