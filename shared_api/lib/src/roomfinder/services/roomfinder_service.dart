import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class RoomfinderService {
  RouteBase get roomfinderData;

  void navigateToRoomfinder(BuildContext context);
}
