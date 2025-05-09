import 'package:core/api.dart';
import 'package:core_routes/mensa.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_api/mensa.dart';

import 'mensa_opening_hours.dart';
import 'mensa_status.dart';

part 'mensa_model.g.dart';

@JsonSerializable()
class MensaModel extends RMensaModel {
  @JsonKey(name: 'id')
  final String canteenId;
  final String name;
  final LocationModel location;
  @JsonKey(name: 'rating')
  final RatingModel ratingModel;
  @JsonKey(name: 'opening_hours')
  final MensaOpeningHours openingHours;
  final List<ImageModel> images;
  final MensaType type;
  final MensaStatus status;

  const MensaModel({
    required this.canteenId,
    required this.name,
    required this.location,
    required this.ratingModel,
    required this.openingHours,
    required this.images,
    required this.type,
    required this.status,
  });

  factory MensaModel.placeholder({String? name}) => MensaModel(
        canteenId: '',
        name: name ?? 'Name',
        location: const LocationModel(
          address: "",
          latitude: 0,
          longitude: 0,
        ),
        ratingModel: RatingModel.placeholder(),
        openingHours: MensaOpeningHours.empty(),
        images: const [
          ImageModel(
            url: "https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png",
            name: "name",
            blurHash: "",
          )
        ],
        type: MensaType.none,
        status: const MensaStatus(isLectureFree: false, isClosed: false, isTemporaryClosed: false),
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
