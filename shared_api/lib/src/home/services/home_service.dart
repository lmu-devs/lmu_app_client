import 'package:flutter/material.dart';

abstract class HomeService {
  void navigateToHome({required BuildContext context, bool hasDeletedUserApiKey = false});
}
