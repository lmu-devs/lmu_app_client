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

    return LmuScaffold(
      appBar: LmuAppBarData(
        leadingAction: LeadingAction.back,
        largeTitle: "Debug",
        trailingWidgets: [
          GestureDetector(
            onTap: () {
              final params = ShareParams(
                files: [XFile(appLogger.logFilePath)],
              );
              SharePlus.instance.share(params);
            },
            child: const LmuIcon(
              icon: LucideIcons.share,
              size: LmuIconSizes.medium,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final lmuToast = LmuToast.of(context);
              await appLogger.clearLogs();
              lmuToast.showToast(message: "Logs cleared");
              LmuVibrations.success();
            },
            child: LmuIcon(
              icon: LucideIcons.circle_x,
              size: LmuIconSizes.medium,
              color: context.colors.dangerColors.textColors.strongColors.active,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: ValueListenableBuilder(
          valueListenable: AppLogger().logsNotifier,
          builder: (context, value, _) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: value.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_2),
                      child: LmuText.bodyXSmall(
                        value[index],
                      ),
                    ),
                    const LmuDivider(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
