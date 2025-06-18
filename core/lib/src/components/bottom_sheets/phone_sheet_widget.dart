import '../../../components.dart';
import '../../../constants.dart';
import '../../../localizations.dart';
import '../../constants/constants.dart';
import '../../../themes.dart';
import '../../../utils.dart';
import 'package:flutter/material.dart';

import '../../../api.dart';

class PhoneSheet extends StatelessWidget {
  const PhoneSheet({super.key, required this.phones});

  final List<PhoneModel> phones;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: LmuSizes.size_8,
            top: LmuSizes.size_4,
            bottom: LmuSizes.size_8,
          ),
          child: LmuText.body(
            context.locals.app.callPhone,
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
        ),
        Column(
          children: phones
              .map(
                (phone) => LmuListItem.base(
                  title: phone.number,
                  subtitle: phone.recipient,
                  onTap: () => LmuUrlLauncher.launchPhone(phoneNumber: phone.number, context: context),
                  onLongPress: () => CopyToClipboardUtil.copyToClipboard(
                    context: context,
                    copiedText: phone.number,
                    message: context.locals.app.copiedPhone,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
