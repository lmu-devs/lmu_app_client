import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../domain/model/grade.dart';
import '../component/grades_in_list_grade.dart';
import '../view/grade_edit_page.dart';

class GradesToggleListItem extends StatefulWidget {
  const GradesToggleListItem({
    super.key,
    required this.grade,
    this.onActiveChanged,
  });

  final Grade grade;

  final void Function(bool isActive)? onActiveChanged;

  @override
  State<GradesToggleListItem> createState() => _GradesToggleListItemState();
}

class _GradesToggleListItemState extends State<GradesToggleListItem> {
  late bool _isActive;

  Grade get _grade => widget.grade;

  @override
  void initState() {
    super.initState();
    _isActive = _grade.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Opacity(
            opacity: _isActive ? 1.0 : 0.4,
            child: LmuListItem.base(
              mainContentAlignment: MainContentAlignment.top,
              title: _grade.name,
              subtitle: "${_grade.ects} ECTS",
              hasHorizontalPadding: false,
              leadingArea: GradesInListGrade(grade: _grade.grade),
              hasVerticalPadding: false,
              onTap: () => GradeEditPage.show(context, grade: _grade),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              _isActive = !_isActive;
            });
            widget.onActiveChanged?.call(_isActive);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: LmuSizes.size_6),
            child: SizedBox(
              height: LmuSizes.size_64,
              width: LmuIconSizes.medium + 2 * LmuSizes.size_6,
              child: LmuIcon(
                icon: _isActive ? LucideIcons.eye : LucideIcons.eye_closed,
                size: LmuIconSizes.medium,
                color: _isActive
                    ? context.colors.neutralColors.textColors.mediumColors.base
                    : context.colors.neutralColors.textColors.weakColors.base,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
