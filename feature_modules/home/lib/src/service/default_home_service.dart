import 'package:flutter/material.dart';
import 'package:shared_api/home.dart';

import '../pages/home_page.dart';

class DefaultHomeService implements HomeService {
  @override
  void navigateToHome({required BuildContext context, bool hasDeletedUserApiKey = false}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }
}
