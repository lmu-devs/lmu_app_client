import 'package:core/components.dart';
import 'package:flutter/material.dart';

class MensaTag extends StatelessWidget {
  const MensaTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.cyanAccent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: JoyText.body(
        "Mensa",
        weight: FontWeight.bold,
      ),
    );
  }
}
