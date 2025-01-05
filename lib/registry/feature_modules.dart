import 'package:explore/explore.dart';
import 'package:feedback/feedback.dart';
import 'package:mensa/mensa.dart';
import 'package:settings/settings.dart';
import 'package:user/user.dart';
import 'package:wishlist/wishlist.dart';
import 'package:home/home.dart';

final modules = [
  UserModule(),
  MensaModule(),
  ExploreModule(),
  WishlistModule(),
  SettingsModule(),
  FeedbackModule(),
  HomeModule(),
];
