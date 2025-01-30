import 'package:core/constants.dart';
import 'package:flutter/material.dart';

class MenuCafeBarView extends StatelessWidget {
  const MenuCafeBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: LmuSizes.size_8,
        horizontal: LmuSizes.size_16,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 25,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
