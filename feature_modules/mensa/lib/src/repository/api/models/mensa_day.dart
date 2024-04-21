import 'package:equatable/equatable.dart';

import 'mensa_entry.dart';

class MensaDay extends Equatable {
  const MensaDay({
    required this.time,
    required this.mensaEntries,
  });

  final DateTime time;
  final List<MensaEntry> mensaEntries;

  MensaDay copyWith({
    DateTime? time,
    List<MensaEntry>? mensaEntries,
  }) {
    return MensaDay(
      time: time ?? this.time,
      mensaEntries: mensaEntries ?? this.mensaEntries,
    );
  }

  @override
  String toString() => 'MensaDay(time: $time)';

  @override
  List<Object?> get props => [
        time,
        mensaEntries,
      ];
}
