import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../application/usecase/get_student_id_data_usecase.dart';
import '../../application/usecase/get_student_id_theme_usecase.dart';
import 'student_id/student_id_card.dart';
import 'student_id/themes/student_id_theme.dart';

class StudentId extends StatelessWidget {
  const StudentId({super.key});

  @override
  Widget build(BuildContext context) {
    final dataUsecase = GetIt.I.get<GetStudentIdDataUsecase>();
    final themeUsecase = GetIt.I.get<GetStudentIdThemeUsecase>();

    return ListenableBuilder(
      listenable: Listenable.merge([dataUsecase, themeUsecase]),
      builder: (context, _) {
        final data = dataUsecase.data;
        if (data == null) return const SizedBox.shrink();

        final themes = StudentIdThemes(context);
        final currentTheme = themes.getById(themeUsecase.selectedThemeId);

        return StudentIdCard(
          data: data,
          theme: currentTheme,
          allThemes: themes.allThemes,
          onThemeSelected: (theme) => themeUsecase.selectTheme(theme.id),
          onMatrikelnrCopy: (_) {
            LmuToast.show(context: context, message: 'Copied Matrikelnr');
            LmuVibrations.secondary();
          },
          onLrzKennungCopy: (_) {
            LmuToast.show(context: context, message: 'Copied LRZ Kennung');
            LmuVibrations.secondary();
          },
        );
      },
    );
  }
}
