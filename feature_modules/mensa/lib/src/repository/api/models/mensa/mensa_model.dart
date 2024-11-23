import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../rating_model.dart';

import 'image_model.dart';
import 'mensa_location.dart';
import 'mensa_opening_hours.dart';
import 'mensa_type.dart';

part 'mensa_model.g.dart';

@JsonSerializable()
class MensaModel extends Equatable {
  @JsonKey(name: 'id')
  final String canteenId;
  final String name;
  final MensaLocation location;
  @JsonKey(name: 'rating')
  final RatingModel ratingModel;
  @JsonKey(name: 'opening_hours')
  final List<MensaOpeningHours> openingHours;
  final List<ImageModel> images;
  final MensaType type;

  const MensaModel({
    required this.canteenId,
    required this.name,
    required this.location,
    required this.ratingModel,
    required this.openingHours,
    required this.images,
    required this.type,
  });

  factory MensaModel.placeholder({String? name}) => MensaModel(
        canteenId: '',
        name: name ?? 'Name',
        location: MensaLocation.placeholder(),
        ratingModel: RatingModel.placeholder(),
        openingHours: const [],
        images: const [ImageModel(url: "https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png", name: "name")],
        type: MensaType.none,
      );

  factory MensaModel.fromJson(Map<String, dynamic> json) => _$MensaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MensaModelToJson(this);

  @override
  List<Object?> get props => [
        canteenId,
        name,
        location,
        ratingModel,
        openingHours,
        images,
      ];
}