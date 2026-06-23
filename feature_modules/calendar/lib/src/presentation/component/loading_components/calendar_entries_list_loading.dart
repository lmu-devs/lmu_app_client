import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../calendar_date_info_label.dart';
import 'calendar_card_loading.dart';

class CalendarListLoading extends StatelessWidget {
  const CalendarListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.size_16),
          CalendarDateInfoLabel.month(
            date: currentDate,
          ),
          Skeletonizer(
            enabled: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDayLabelSkeleton(),
                _buildCardWrapper(const CalendarCardLoading()),
                _buildCardWrapper(const CalendarCardLoading()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_32),
                  child: Center(
                    child: Bone.text(
                      words: 3,
                      style: TextStyle(fontSize: 14, color: context.colors.neutralColors.textColors.weakColors.base),
                    ),
                  ),
                ),
                _buildDayLabelSkeleton(),
                _buildCardWrapper(const CalendarCardLoading()),
              ],
            ),
          ),
          CalendarDateInfoLabel.month(
            date: currentDate.addMonth(),
          ),
          Skeletonizer(
            enabled: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDayLabelSkeleton(),
                _buildCardWrapper(const CalendarCardLoading()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_32),
                  child: Center(
                    child: Bone.text(
                      words: 3,
                      style: TextStyle(fontSize: 14, color: context.colors.neutralColors.textColors.weakColors.base),
                    ),
                  ),
                ),
                _buildDayLabelSkeleton(),
                _buildCardWrapper(const CalendarCardLoading()),
              ],
            ),
          ),
          const SizedBox(height: LmuSizes.size_32),
          Center(
              child: LmuText(
            'Sorry that it takes so long to load!\n(ó_Ò)',
            color: context.colors.neutralColors.textColors.weakColors.disabled,
            textAlign: TextAlign.center,
          )),
          const SizedBox(height: LmuSizes.size_32),
        ],
      ),
    );
  }

  Widget _buildDayLabelSkeleton() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16, vertical: LmuSizes.size_12),
      child: Bone.text(
        words: 2,
        fontSize: 16,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCardWrapper(Widget child) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(LmuSizes.size_8, 0, LmuSizes.size_8, LmuSizes.size_6),
      child: child,
    );
  }
}
