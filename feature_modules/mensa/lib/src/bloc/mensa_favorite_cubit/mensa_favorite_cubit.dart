import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/mensa_repository.dart';

part 'mensa_favorite_state.dart';

class MensaFavoriteCubit extends Cubit<MensaFavoriteState> {
  MensaFavoriteCubit({
    required MensaRepository mensaRepository,
  })  : _mensaRepository = mensaRepository,
        super(MensaFavoriteInitial()) {
    _initFavoriteMensaIds();
  }

  final MensaRepository _mensaRepository;

  void _initFavoriteMensaIds() async {
    emit(MensaFavoriteLoadInProgress());
    final favoriteMensaIds = await _mensaRepository.getFavoriteMensaIds();

    if (favoriteMensaIds != null) {
      emit(MensaFavoriteLoadSuccess(favoriteMensaIds: favoriteMensaIds));
    } else {
      emit(const MensaFavoriteLoadSuccess(favoriteMensaIds: []));
    }
  }

  void toggleFavoriteMensa({
    required String mensaId,
  }) async {
    final currenFavorites = List<String>.from((state as MensaFavoriteLoadSuccess).favoriteMensaIds);
    if (currenFavorites.contains(mensaId)) {
      currenFavorites.remove(mensaId);
    } else {
      currenFavorites.add(mensaId);
    }
    emit(MensaFavoriteLoadSuccess(favoriteMensaIds: currenFavorites));
    await _mensaRepository.updateFavoriteMensaIds(currenFavorites);
  }

  @override
  Future<void> close() async {
    final currenFavorites = (state as MensaFavoriteLoadSuccess).favoriteMensaIds;

    await _mensaRepository.updateFavoriteMensaIds(currenFavorites);
    super.close();
  }
}
