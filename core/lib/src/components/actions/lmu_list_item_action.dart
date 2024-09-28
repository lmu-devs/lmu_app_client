import 'package:flutter/material.dart';

import 'actions.dart';

enum LmuListItemAction {
  dropdown,
  toggle,
  radio,
  chevron,
  checkbox,
}

extension WidgetConfiguration on LmuListItemAction {
  Widget getWidget({required bool isActive, String? chevronTitle}) {
    switch (this) {
      case LmuListItemAction.dropdown:
        return LmuDropDownAction(isActive: isActive);
      case LmuListItemAction.checkbox:
        return LmuCheckboxAction(isActive: isActive);
      case LmuListItemAction.radio:
        return LmuRadioAction(isActive: isActive);
      case LmuListItemAction.chevron:
        return LmuChevronAction(chevronTitle: chevronTitle);
      case LmuListItemAction.toggle:
        return LmuToggleAction(isActive: isActive);
      default:
        return const SizedBox.shrink();
    }
  }
}
