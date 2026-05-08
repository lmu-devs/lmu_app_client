import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../themes/student_id_theme.dart';

class StudentIdBackSide extends StatelessWidget {
  const StudentIdBackSide({
    super.key,
    required this.allThemes,
    required this.currentTheme,
    required this.onThemeSelected,
  });

  final List<StudentIdTheme> allThemes;
  final StudentIdTheme currentTheme;
  final ValueChanged<StudentIdTheme> onThemeSelected;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(math.pi),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Theme',
              style: TextStyle(
                color: currentTheme.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: allThemes.length,
                itemBuilder: (context, index) {
                  final theme = allThemes[index];
                  final isSelected = currentTheme.id == theme.id;

                  return GestureDetector(
                    onTap: () => onThemeSelected(theme),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isSelected ? currentTheme.textColor : theme.borderColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 24,
                            height: 18,
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.textColor.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: isSelected ? Icon(Icons.check, color: theme.textColor, size: 18) : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            theme.name,
                            style: TextStyle(
                              color: theme.textColor,
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
