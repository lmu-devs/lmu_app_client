import 'package:core/components.dart';
import 'package:flutter/material.dart';

class LinksLoadingView extends StatelessWidget {
  const LinksLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LmuText.body("LOADING"),
    );
  }
}
