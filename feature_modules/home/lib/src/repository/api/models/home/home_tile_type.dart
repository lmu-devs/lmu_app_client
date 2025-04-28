import 'package:json_annotation/json_annotation.dart';

enum HomeTileType {
  @JsonValue("BENEFITS")
  benefits,

  @JsonValue("TIMELINE")
  timeline,

  @JsonValue("SPORTS")
  sports,

  @JsonValue("ROOMFINDER")
  roomfinder,

  @JsonValue("CINEMAS")
  cinemas,

  @JsonValue("WISHLIST")
  wishlist,

  @JsonValue("FEEDBACK")
  feedback,

  @JsonValue("LINKS")
  links,

  @JsonValue("NEWS")
  news,

  @JsonValue("EVENTS")
  events,

  @JsonValue("MENSA")
  mensa,

  @JsonValue("LIBRARIES")
  libraries,

  @JsonValue("OTHER")
  other
}
