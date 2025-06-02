import 'package:flutter/foundation.dart';

import '../../domain/model/people.dart';
import '../usecase/get_cached_people_usecase.dart';
import '../usecase/get_people_usecase.dart';

enum PeopleLoadState { initial, loading, loadingWithCache, success, error }

typedef PeopleState = ({PeopleLoadState loadState, People? people});

class PeopleStateService {
  PeopleStateService(this._getPeopleUsecase, this._getCachedPeopleUsecase);

  final GetPeopleUsecase _getPeopleUsecase;
  final GetCachedPeopleUsecase _getCachedPeopleUsecase;

// Observable of Viewmodel - wenn Änderungen an den Daten vorgenommen werden, wird der View benachrichtigt
  final ValueNotifier<PeopleState> _stateNotifier = ValueNotifier<PeopleState>(
    (loadState: PeopleLoadState.initial, people: null),
  );

  ValueListenable<PeopleState> get stateNotifier => _stateNotifier;

//Schnittstelle zu Backend-Daten
  Future<void> getPeople() async {
    final currentState = _stateNotifier.value.loadState;
    if (currentState == PeopleLoadState.loading || currentState == PeopleLoadState.success) return;

    final cachedPeople = await _getCachedPeopleUsecase.call();
    if (cachedPeople != null) {
      _stateNotifier.value = (loadState: PeopleLoadState.loadingWithCache, people: cachedPeople);
    } else {
      _stateNotifier.value = (loadState: PeopleLoadState.loading, people: null);
    }

    final people = await _getPeopleUsecase.call();
    if (people != null) {
      _stateNotifier.value = (loadState: PeopleLoadState.success, people: people);
      return;
    }
    _stateNotifier.value = (loadState: PeopleLoadState.error, people: null);
    // TODO: Wenn Laden fehlschlägt, gecachte Daten anzeigen lassen (siehe Benefits State Service)
  }
}
