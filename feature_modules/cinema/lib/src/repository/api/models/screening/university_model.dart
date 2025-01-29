import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'university_model.g.dart';

@JsonSerializable()
class UniversityModel extends Equatable {
  const UniversityModel({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  @override
  List<Object?> get props => [
        id,
        title,
      ];

  factory UniversityModel.fromJson(Map<String, dynamic> json) => _$UniversityModelFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityModelToJson(this);
}
