import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/model/student_id_data.dart';
import '../themes/student_id_theme.dart';

class StudentIdFrontSide extends StatelessWidget {
  const StudentIdFrontSide({
    super.key,
    required this.data,
    required this.theme,
    required this.onMatrikelnrCopy,
    required this.onLrzKennungCopy,
  });

  final StudentIdData data;
  final StudentIdTheme theme;
  final ValueChanged<String>? onMatrikelnrCopy;
  final ValueChanged<String>? onLrzKennungCopy;

  static const _logoAsset = 'packages/core/assets/holograms/legal_logo.svg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // LMU Logo
        Positioned(
          top: 20,
          left: 20,
          child: SvgPicture.asset(
            _logoAsset,
            width: 60,
            height: 40,
            colorFilter: ColorFilter.mode(theme.logoColor, BlendMode.srcIn),
          ),
        ),

        // Name
        Positioned(
          top: 70,
          left: 20,
          child: Text(
            data.name,
            style: TextStyle(
              color: theme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Email
        Positioned(
          top: 95,
          left: 20,
          child: Text(
            data.email,
            style: TextStyle(
              color: theme.secondaryTextColor,
              fontSize: 14,
            ),
          ),
        ),

        // Valid until
        Positioned(
          top: 115,
          left: 20,
          child: Text(
            data.validUntil,
            style: TextStyle(
              color: theme.textColor,
              fontSize: 14,
            ),
          ),
        ),

        // Matrikelnr
        Positioned(
          bottom: 20,
          left: 20,
          child: _CopyableField(
            label: 'Matrikelnr',
            value: data.matrikelnr,
            textColor: theme.textColor,
            secondaryTextColor: theme.secondaryTextColor,
            onCopy: onMatrikelnrCopy,
          ),
        ),

        // LRZ Kennung
        Positioned(
          bottom: 20,
          right: 20,
          child: _CopyableField(
            label: 'LRZ Kennung',
            value: data.lrzKennung,
            textColor: theme.textColor,
            secondaryTextColor: theme.secondaryTextColor,
            crossAxisAlignment: CrossAxisAlignment.end,
            onCopy: onLrzKennungCopy,
          ),
        ),

        // Braille
        Positioned(
          top: 30,
          right: 30,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(-1.0, 1.0),
            child: Text(
              '⠇⠍⠥',
              style: TextStyle(
                color: theme.textColor.withOpacity(0.3),
                fontSize: 24,
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CopyableField extends StatelessWidget {
  const _CopyableField({
    required this.label,
    required this.value,
    required this.textColor,
    required this.secondaryTextColor,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.onCopy,
  });

  final String label;
  final String value;
  final Color textColor;
  final Color secondaryTextColor;
  final CrossAxisAlignment crossAxisAlignment;
  final ValueChanged<String>? onCopy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: TextStyle(
            color: secondaryTextColor,
            fontSize: 12,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: onCopy != null
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      onCopy!(value);
                    }
                  : null,
              child: Icon(
                Icons.copy,
                color: secondaryTextColor,
                size: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
