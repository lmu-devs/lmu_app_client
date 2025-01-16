import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class CinemaService {
  Widget get cinemaMainPage;

  RouteBase get cinemaData;
}
