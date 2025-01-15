import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import 'package:shared_api/home.dart';

class DefaultHomeService implements HomeService {
  @override
  void navigateToHome({required BuildContext context, bool hasDeletedUserApiKey = false}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomePage(hasDeletedUserApiKey: hasDeletedUserApiKey),
      ),
    );
  }
}
