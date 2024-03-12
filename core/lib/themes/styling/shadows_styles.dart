import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import '../color_primitives.dart';

class ShadowStyles {

  // DARK
  static const BoxShadow darkPrimaryLevitatedOutside = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, .8),
    blurRadius: 2,
    offset: Offset(0, 1),
    spreadRadius: 0,
  );
  static const BoxShadow darkPrimaryLevitatedInside = BoxShadow(
    color: Color.fromRGBO(255, 255, 255, .9),
    blurRadius: 1,
    offset: Offset(0, .5),
    inset: true,
  );

  static const BoxShadow darkSecondaryLevitatedOutside = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    blurRadius: 2,
    offset: Offset(0, 1),
  );
  static const BoxShadow darkSecondaryLevitatedInside = BoxShadow(
    color: Color.fromRGBO(255, 255, 255, 0.55),
    blurRadius: .5,
    offset: Offset(0, .5),
    inset: true,
  );


  // LIGHT
  static const BoxShadow lightPrimaryLevitatedInside = BoxShadow(
    color: Color.fromRGBO(255, 255, 255, 0.9),
    blurRadius: .5,
    offset: Offset(0, .5),
    inset: true
  );
  static const BoxShadow lightPrimaryLevitatedInside2 = BoxShadow(
    color: Color.fromRGBO(255, 255, 255, 0.75),
    blurRadius: 1,
    offset: Offset(0, 1),
    inset: true,
  );

  static const BoxShadow lightSecondaryLevitatedOutside = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 1,
    offset: Offset(0, 1),
  );
  static const BoxShadow lightSecondaryLevitatedInside = BoxShadow(
    color: Color.fromRGBO(255, 255, 255, 1),
    blurRadius: 1,
    offset: Offset(0, 1),
    inset: true,
  );


}
