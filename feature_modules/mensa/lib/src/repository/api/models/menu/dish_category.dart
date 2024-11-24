import 'package:json_annotation/json_annotation.dart';

//Order defines the order of the menu page
enum DishCategory {
  @JsonValue('MAIN')
  main,
  @JsonValue('SOUP')
  soup,
  @JsonValue('SIDES')
  sides,
  @JsonValue('DESSERT')
  dessert,
}
