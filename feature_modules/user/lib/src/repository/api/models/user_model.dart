import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({required this.apiKey});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @JsonKey(name: 'api_key')
  final String apiKey;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
