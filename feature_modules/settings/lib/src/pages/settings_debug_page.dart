import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/logging.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:share_plus/share_plus.dart';

class SettingsDebugPage extends StatelessWidget {
  const SettingsDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLogger = AppLogger();

    return LmuMasterAppBar(
      leadingAction: LeadingAction.back,
      largeTitle: "Debug",
      trailingWidgets: [
        GestureDetector(
          onTap: () {
            Share.shareXFiles([XFile(appLogger.logFilePath)]);
          },
          child: const LmuIcon(
            icon: LucideIcons.share,
            size: LmuIconSizes.medium,
          ),
        ),
        GestureDetector(
          onTap: () async {
            appLogger.clearLogs().then(
                  (value) => LmuToast.show(
                    context: context,
                    message: "Logs cleared",
                    type: ToastType.success,
                  ),
                );
            LmuVibrations.success();
          },
          child: LmuIcon(
            icon: LucideIcons.circle_x,
            size: LmuIconSizes.medium,
            color: context.colors.dangerColors.textColors.strongColors.active,
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: ValueListenableBuilder(
          valueListenable: AppLogger().logsNotifier,
          builder: (context, value, _) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                return LmuText.bodyXSmall(
                  value[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
