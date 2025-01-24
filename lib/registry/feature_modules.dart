import 'package:cinema/cinema.dart';
import 'package:explore/explore.dart';
import 'package:feedback/feedback.dart';
import 'package:home/home.dart';
import 'package:mensa/mensa.dart';
import 'package:settings/settings.dart';
import 'package:sports/sports.dart';
import 'package:user/user.dart';
import 'package:wishlist/wishlist.dart';

final modules = [
  UserModule(),
  HomeModule(),
  CinemaModule(),
  MensaModule(),
  ExploreModule(),
  WishlistModule(),
  SettingsModule(),
  FeedbackModule(),
  SportsModule(),
];
