import 'package:core/components.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../application/usecase/ects_config_usecase.dart';
import '../view/grades_ects_setup_page.dart';

/// Wraps the grades page and opens the ECTS setup bottom sheet once, whenever
/// the user has not configured a total ECTS value yet.
class GradesEctsSetupGate extends StatefulWidget {
  const GradesEctsSetupGate({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GradesEctsSetupGate> createState() => _GradesEctsSetupGateState();
}

class _GradesEctsSetupGateState extends State<GradesEctsSetupGate> {
  final _ectsConfigUsecase = GetIt.I.get<EctsConfigUsecase>();

  bool _hasShownSheet = false;

  @override
  void initState() {
    super.initState();
    _ectsConfigUsecase.addListener(_maybeShowSetup);
    _maybeShowSetup();
  }

  @override
  void dispose() {
    _ectsConfigUsecase.removeListener(_maybeShowSetup);
    super.dispose();
  }

  void _maybeShowSetup() {
    if (_hasShownSheet) return;
    if (!_ectsConfigUsecase.isLoaded || _ectsConfigUsecase.isConfigured) return;

    _hasShownSheet = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _showSetupSheet();
    });
  }

  void _showSetupSheet() {
    LmuBottomSheet.showExtended(
      context,
      isDismissible: false,
      enableDrag: false,
      content: GradesEctsSetupPage(
        onSave: (value) {
          _ectsConfigUsecase.setTotalEcts(value);
          Navigator.of(context, rootNavigator: true).pop();
        },
        onClose: () {
          Navigator.of(context, rootNavigator: true).pop();
          final navigator = Navigator.of(context);
          if (navigator.canPop()) navigator.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
