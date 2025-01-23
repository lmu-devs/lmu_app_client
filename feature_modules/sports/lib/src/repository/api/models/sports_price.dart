import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sports_price.g.dart';

@JsonSerializable()
class SportsPrice extends Equatable {
  const SportsPrice({
    required this.studentPrice,
    required this.employeePrice,
    required this.externalPrice,
  });

  @JsonKey(name: 'student_price')
  final double studentPrice;
  @JsonKey(name: 'employee_price')
  final double employeePrice;
  @JsonKey(name: 'external_price')
  final double externalPrice;

  factory SportsPrice.fromJson(Map<String, dynamic> json) => _$SportsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$SportsPriceToJson(this);

  @override
  List<Object?> get props => [studentPrice, employeePrice, externalPrice];
}
