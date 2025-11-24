import 'package:json_annotation/json_annotation.dart';

part 'frequency.g.dart';

@JsonEnum(alwaysCreate: true)
enum Frequency {
  @JsonValue('ONCE')
  once('Nie'),

  @JsonValue('DAILY')
  daily('Täglich'),

  @JsonValue('WEEKLY')
  weekly('Wöchentlich'),

  @JsonValue('MONTHLY')
  monthly('Monatlich'),

  @JsonValue('YEARLY')
  yearly('Jährlich');

  const Frequency(this.label);
  final String label;

  static Frequency fromLabel(String label) {
    return Frequency.values.firstWhere(
      (e) => e.label == label,
      orElse: () => Frequency.once,
    );
  }

  // function that returns a map of the string and the enum value
  static Map<String, Frequency> get labelMap {
    return {
      for (var freq in Frequency.values) freq.label: freq,
    };
  }
}
