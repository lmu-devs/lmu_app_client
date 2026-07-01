import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../application/usecase/ects_config_usecase.dart';

const List<double> _presetEctsValues = [120.0, 180.0];

class GradesEctsSetupPage extends StatefulWidget {
  const GradesEctsSetupPage({
    super.key,
    required this.onSave,
    required this.onClose,
  });

  final ValueChanged<double> onSave;
  final VoidCallback onClose;

  @override
  State<GradesEctsSetupPage> createState() => _GradesEctsSetupPageState();
}

class _GradesEctsSetupPageState extends State<GradesEctsSetupPage> {
  final _customController = TextEditingController();

  double? _selectedPreset;
  bool _isCustomSelected = false;

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  double? get _selectedValue {
    if (_isCustomSelected) return parseTotalEcts(_customController.text);
    return _selectedPreset;
  }

  bool get _isSaveEnabled => _selectedValue != null;

  void _onPresetSelected(double value) {
    setState(() {
      _selectedPreset = value;
      _isCustomSelected = false;
    });
  }

  void _onCustomSelected() {
    setState(() {
      _isCustomSelected = true;
      _selectedPreset = null;
    });
  }

  void _onCustomChanged(String value) {
    setState(() {});
  }

  void _onSavePressed() {
    final value = _selectedValue;
    if (value == null) return;
    widget.onSave(value);
  }

  @override
  Widget build(BuildContext context) {
    final gradesL10n = context.locals.grades;

    return LmuScaffold(
      customScrollController: context.modalScrollController,
      isBottomSheet: true,
      appBar: LmuAppBarData(
        largeTitle: gradesL10n.ectsSetupTitle,
        leadingAction: LeadingAction.close,
        onLeadingActionTap: widget.onClose,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: LmuButton(
            title: gradesL10n.saveButton,
            size: ButtonSize.large,
            showFullWidth: true,
            state: _isSaveEnabled ? ButtonState.enabled : ButtonState.disabled,
            onTap: _onSavePressed,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(
              gradesL10n.ectsSetupDescription,
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuButtonRow(
              hasHorizontalPadding: false,
              buttons: [
                ..._presetEctsValues.map(
                  (value) {
                    final isSelected = !_isCustomSelected && _selectedPreset == value;
                    return LmuButton(
                      title: value.toInt().toString(),
                      emphasis: isSelected ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                      action: isSelected ? ButtonAction.contrast : ButtonAction.base,
                      onTap: () => _onPresetSelected(value),
                    );
                  },
                ),
                LmuButton(
                  title: gradesL10n.ectsSetupCustom,
                  emphasis: _isCustomSelected ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                  action: _isCustomSelected ? ButtonAction.contrast : ButtonAction.base,
                  onTap: _onCustomSelected,
                ),
              ],
            ),
            if (_isCustomSelected) ...[
              const SizedBox(height: LmuSizes.size_16),
              LmuInputField(
                hintText: gradesL10n.ectsSetupCustomHint,
                controller: _customController,
                maxLength: 3,
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                onChanged: _onCustomChanged,
              ),
            ],
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
