// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

class MensaOpeningHours extends Equatable {
  const MensaOpeningHours({
    required this.dayAsEnum,
    required this.openingHours,
  });

  final Weekday? dayAsEnum;
  final List<String> openingHours;

  MensaOpeningHours copyWith({
    Weekday? dayAsEnum,
    List<String>? openingHours,
  }) {
    return MensaOpeningHours(
      dayAsEnum: dayAsEnum ?? this.dayAsEnum,
      openingHours: openingHours ?? this.openingHours,
    );
  }

  @override
  List<Object> get props => [openingHours];
}
