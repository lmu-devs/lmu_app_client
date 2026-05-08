import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../components.dart';
import '../../themes.dart';

class CopyToClipboardUtil {
  CopyToClipboardUtil._();

  static void copyToClipboard({
    required BuildContext context,
    required String copiedText,
    required String message,
    bool pop = false,
    ToastType type = ToastType.success,
  }) {
    Clipboard.setData(ClipboardData(text: copiedText));
    LmuVibrations.secondary();
    if (pop && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    LmuToast.show(
      context: context,
      message: message,
      type: type,
    );
  }
}
