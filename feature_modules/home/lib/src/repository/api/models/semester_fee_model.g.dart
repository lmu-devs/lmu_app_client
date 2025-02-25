// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_fee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemesterFeeModel _$SemesterFeeModelFromJson(Map<String, dynamic> json) =>
    SemesterFeeModel(
      fee: (json['fee'] as num).toDouble(),
      timePeriod:
          TimePeriodModel.fromJson(json['time_period'] as Map<String, dynamic>),
      iban: json['iban'] as String,
      bic: json['bic'] as String,
      receiver: json['receiver'] as String,
      reference: json['reference'] as String,
    );

Map<String, dynamic> _$SemesterFeeModelToJson(SemesterFeeModel instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'time_period': instance.timePeriod,
      'iban': instance.iban,
      'bic': instance.bic,
      'receiver': instance.receiver,
      'reference': instance.reference,
    };
