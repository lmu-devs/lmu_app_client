import 'package:benefits/benefits.dart';
import 'package:calendar/calendar.dart';
import 'package:cinema/cinema.dart';
import 'package:courses/courses.dart';
import 'package:developerdex/developerdex.dart';
import 'package:explore/explore.dart';
import 'package:feedback/feedback.dart';
import 'package:home/home.dart';
import 'package:launch_flow/launch_flow.dart';
import 'package:lectures/lectures.dart';
import 'package:libraries/libraries.dart';
import 'package:mensa/mensa.dart';
import 'package:people/people.dart';
import 'package:roomfinder/roomfinder.dart';
import 'package:settings/settings.dart';
import 'package:sports/sports.dart';
import 'package:studies/studies.dart';
import 'package:timeline/timeline.dart';
import 'package:user/user.dart';
import 'package:wishlist/wishlist.dart';

final modules = [
  UserModule(),
  HomeModule(),
  CinemaModule(),
  RoomfinderModule(),
  MensaModule(),
  LibrariesModule(),
  ExploreModule(),
  WishlistModule(),
  SettingsModule(),
  FeedbackModule(),
  SportsModule(),
  TimelineModule(),
  BenefitsModule(),
  StudiesModule(),
  LaunchFlowModule(),
  CalendarModule(),
  LecturesModule(),
  CoursesModule(),
  PeopleModule(),
  DeveloperdexModule(),
];
