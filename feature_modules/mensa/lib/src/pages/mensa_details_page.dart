import 'package:core/components.dart';
import 'package:flutter/material.dart';

class MensaDetailsPage extends StatelessWidget {
  const MensaDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("MENSADETAILS"),
            LmuButton(
              text: "PREASS ME",
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (sheetContext) => SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 500,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
