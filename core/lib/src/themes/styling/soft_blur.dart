import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../constants.dart';

class SoftBlur extends StatelessWidget {
  const SoftBlur({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: MediaQuery.of(context).padding.top - LmuSizes.size_8,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.25, sigmaY: 1.25),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
