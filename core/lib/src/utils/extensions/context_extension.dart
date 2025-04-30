import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

extension ModalBottomSheetScrollControllerGetter on BuildContext {
  ScrollController get modalScrollController => ModalScrollController.of(this)!;
}
