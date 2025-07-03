// lib/screens/settings_notifications_page.dart (Final, Robust Solution)

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart' show PermissionStatus;

class SettingsNotificationsPage extends StatefulWidget {
  const SettingsNotificationsPage({super.key});

  @override
  State<SettingsNotificationsPage> createState() =>
      _SettingsNotificationsPageState();
}

class _SettingsNotificationsPageState extends State<SettingsNotificationsPage> with WidgetsBindingObserver {
  final _notificationsPreferenceService = GetIt.I<NotificationsUserPreferenceService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _notificationsPreferenceService.refreshStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.settings.notificationsTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: LmuSizes.size_16,
        ),
        child: Column(
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuContentTile(
              content: ValueListenableBuilder<PermissionStatus?>(
                valueListenable: _notificationsPreferenceService.permissionStatus,
                builder: (context, status, child) {
                  final bool isEnabled = PermissionsService.isNotificationsPermissionGranted(status);

                  return LmuListItem.action(
                    key: ValueKey<bool>(isEnabled),
                    title: context.locals.settings.notificationsSwitch,
                    actionType: LmuListItemAction.toggle,
                    initialValue: isEnabled,
                    onChange: (value) async {
                      LmuVibrations.secondary();
                      await PermissionsService.showNotificationsPermissionDialog(context);
                      _notificationsPreferenceService.refreshStatus();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: LmuSizes.size_16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: LmuText.bodyXSmall(
                context.locals.settings.notificationsDescription,
                color: context.colors.neutralColors.textColors.weakColors.base,
              ),
            ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
