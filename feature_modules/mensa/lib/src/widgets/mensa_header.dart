import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MensaHeader extends StatelessWidget {
  const MensaHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/'),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.red,
      ),
    );
  }
}
