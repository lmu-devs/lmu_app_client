import 'package:flutter/widgets.dart';

import '../widgets/mensa_header.dart';

class MensaContentView extends StatelessWidget {
  const MensaContentView({
    required this.mensaData,
    super.key,
  });

  final String mensaData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const MensaHeader(),
        Center(
          child: Text(mensaData),
        ),
      ],
    );
  }
}
