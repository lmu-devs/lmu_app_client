// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'mensa_day.dart';

class MensaOverview extends Equatable {
  const MensaOverview({
    required this.mensaDays,
  });

  final List<MensaDay> mensaDays;

  MensaOverview copyWith({
    List<MensaDay>? mensaDays,
  }) {
    return MensaOverview(
      mensaDays: mensaDays ?? this.mensaDays,
    );
  }

  @override
  String toString() => 'MensaOverview(mensaDays: $mensaDays)';

  @override
  List<Object?> get props => [
        mensaDays,
      ];
}
