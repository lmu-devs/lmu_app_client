import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone_model.g.dart';

@JsonSerializable()
class PhoneModel extends Equatable {
  const PhoneModel({
    required this.number,
    this.recipient,
  });

  factory PhoneModel.fromJson(Map<String, dynamic> json) => _$PhoneModelFromJson(json);

  final String number;
  final String? recipient;

  Map<String, dynamic> toJson() => _$PhoneModelToJson(this);

  @override
  List<Object?> get props => [number, recipient];
}
