import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CopyToClipboardUtil {
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
