import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'time_period_model.dart';

part 'semester_fee_model.g.dart';

@JsonSerializable()
class SemesterFeeModel extends Equatable {
  @JsonKey(name: 'fee')
  final double fee;
  @JsonKey(name: 'time_period')
  final TimePeriodModel timePeriod;
  @JsonKey(name: 'iban')
  final String iban;
  @JsonKey(name: 'bic')
  final String bic;
  @JsonKey(name: 'receiver')
  final String receiver;
  @JsonKey(name: 'reference')
  final String reference;

  const SemesterFeeModel({
    required this.fee,
    required this.timePeriod,
    required this.iban,
    required this.bic,
    required this.receiver,
    required this.reference,
  });

  factory SemesterFeeModel.fromJson(Map<String, dynamic> json) => _$SemesterFeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SemesterFeeModelToJson(this);

  @override
  List<Object?> get props => [
        fee,
        timePeriod,
        iban,
        bic,
        receiver,
        reference,
      ];
}
