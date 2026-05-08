import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../domain/model/grade_semester.dart';
import '../helpers/grade_form_constants.dart';
import '../helpers/grades_formatting_extension.dart';

class GradeFormBody extends StatelessWidget {
  const GradeFormBody({
    super.key,
    required this.selectedGradeSemester,
    required this.onGradeSemesterSelected,
    required this.nameController,
    required this.onNameChanged,
    required this.ectsController,
    required this.onEctsChanged,
    required this.sliderIndex,
    required this.sliderGradeValue,
    required this.noGradeReceived,
    required this.onSliderIndexChanged,
    required this.onNoGradeReceivedChanged,
  });

  final GradeSemester selectedGradeSemester;
  final ValueChanged<GradeSemester> onGradeSemesterSelected;
  final TextEditingController nameController;
  final ValueChanged<String> onNameChanged;
  final TextEditingController ectsController;
  final ValueChanged<String> onEctsChanged;
  final int sliderIndex;
  final double sliderGradeValue;
  final bool noGradeReceived;
  final ValueChanged<int> onSliderIndexChanged;
  final ValueChanged<bool> onNoGradeReceivedChanged;

  @override
  Widget build(BuildContext context) {
    final gradesL10n = context.locals.grades;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        LmuButtonRow(
          buttons: GradeSemester.values.reversed.map((semester) {
            final isSelected = selectedGradeSemester == semester;
            return LmuButton(
              title: semester.localizedName(gradesL10n),
              emphasis: isSelected ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
              action: isSelected ? ButtonAction.contrast : ButtonAction.base,
              onTap: () => onGradeSemesterSelected(semester),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: gradesL10n.nameLabel, customBottomPadding: 4),
              LmuInputField(
                hintText: gradesL10n.nameHint,
                controller: nameController,
                maxLength: 50,
                onChanged: onNameChanged,
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: gradesL10n.ects, customBottomPadding: 4),
              LmuInputField(
                hintText: gradesL10n.ectsHint,
                controller: ectsController,
                maxLength: 3,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                onChanged: onEctsChanged,
              ),
            ],
          ),
        ),
        const SizedBox(height: LmuSizes.size_16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              LmuTileHeadline.base(title: gradesL10n.gradeLabel, customBottomPadding: 8),
              LmuContentTile(
                contentList: [
                  const SizedBox(height: LmuSizes.size_12),
                  LmuText.h1(
                    noGradeReceived ? "‒,‒" : sliderGradeValue.asStringWithOneDecimal,
                  ),
                  const SizedBox(height: LmuSizes.size_8),
                  LmuSlider(
                    value: sliderIndex.toDouble(),
                    min: 0,
                    max: (availableGrades.length - 1).toDouble(),
                    divisions: availableGrades.length - 1,
                    isDisabled: noGradeReceived,
                    onChanged: (value) => onSliderIndexChanged(value.round()),
                  ),
                  const SizedBox(height: LmuSizes.size_12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_8),
                    child: LmuDivider(),
                  ),
                  LmuContentTile(
                    content: LmuListItem.action(
                      title: gradesL10n.noGradeReceived,
                      actionType: LmuListItemAction.toggle,
                      initialValue: noGradeReceived,
                      onChange: (value) => onNoGradeReceivedChanged(value),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }
}
