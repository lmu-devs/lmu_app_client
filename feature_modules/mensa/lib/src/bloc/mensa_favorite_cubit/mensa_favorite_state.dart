part of 'mensa_favorite_cubit.dart';

abstract class MensaFavoriteState extends Equatable {
  const MensaFavoriteState();

  @override
  List<Object> get props => [];
}

class MensaFavoriteInitial extends MensaFavoriteState {}

class MensaFavoriteLoadInProgress extends MensaFavoriteState {}

class MensaFavoriteLoadSuccess extends MensaFavoriteState {
  const MensaFavoriteLoadSuccess({
    required this.favoriteMensaIds,
  });

  final List<String> favoriteMensaIds;

  @override
  List<Object> get props => [favoriteMensaIds];
}
