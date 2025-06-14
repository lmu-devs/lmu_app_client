import 'package:flutter/foundation.dart';

import '../../domain/model/people_category.dart';
import '../usecase/get_cached_people_usecase.dart';
import '../usecase/get_people_usecase.dart';

enum PeopleLoadState { initial, loading, loadingWithCache, success, error }

typedef PeopleState = ({PeopleLoadState loadState, List<PeopleCategory> peopleCategories});

class PeopleStateService {
  PeopleStateService(this._getPeopleUsecase, this._getCachedPeopleUsecase);

  final GetPeopleUsecase _getPeopleUsecase;
  final GetCachedPeopleUsecase _getCachedPeopleUsecase;

// Observable of Viewmodel - wenn Änderungen an den Daten vorgenommen werden, wird der View benachrichtigt
  final ValueNotifier<PeopleState> _stateNotifier = ValueNotifier<PeopleState>(
    (loadState: PeopleLoadState.initial, peopleCategories: []),
  );

  ValueListenable<PeopleState> get state => _stateNotifier;

  PeopleCategory? selectedCategory;

//Schnittstelle zu Backend-Daten
  Future<void> getPeople() async {
    final loadState = _stateNotifier.value.loadState;
    if (loadState == PeopleLoadState.loading ||
        loadState == PeopleLoadState.loadingWithCache ||
        loadState == PeopleLoadState.success) {
      return;
    }

    final cachedPeople = await _getCachedPeopleUsecase.call();
    if (cachedPeople != null) {
      _stateNotifier.value = (loadState: PeopleLoadState.loadingWithCache, peopleCategories: cachedPeople);
    } else {
      _stateNotifier.value = (loadState: PeopleLoadState.loading, peopleCategories: []);
    }

    final people = await _getPeopleUsecase.call();
    if (people == null && cachedPeople == null) {
      _stateNotifier.value = (loadState: PeopleLoadState.error, peopleCategories: []);
      return;
    }
    _stateNotifier.value = (loadState: PeopleLoadState.success, peopleCategories: people ?? cachedPeople!);
    // TODO: Wenn Laden fehlschlägt, gecachte Daten anzeigen lassen (siehe Benefits State Service)
  }
}
