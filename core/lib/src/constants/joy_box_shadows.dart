import 'package:flutter/material.dart';

class JoyBoxShadows {
  static const noBoxShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.0),
    blurRadius: 0,
    offset: Offset(0, 0),
  );

  static const boxShadowSmall = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    blurRadius: 3,
    offset: Offset(0, 1),
  );

  static const boxShadowMedium = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    blurRadius: 6,
    offset: Offset(0, 2),
  );

  static const boxShadowLarge = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    blurRadius: 10,
    offset: Offset(0, 8),
  );
}
