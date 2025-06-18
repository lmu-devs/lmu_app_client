import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poster_model.g.dart';

@JsonSerializable()
class PosterModel extends Equatable {
  const PosterModel({
    required this.url,
    required this.name,
    required this.blurHash,
  });

  factory PosterModel.fromJson(Map<String, dynamic> json) => _$PosterModelFromJson(json);

  final String url;
  final String name;
  @JsonKey(name: 'blurhash')
  final String? blurHash;

  @override
  List<Object?> get props => [
        url,
        name,
        blurHash,
      ];

  Map<String, dynamic> toJson() => _$PosterModelToJson(this);
}
