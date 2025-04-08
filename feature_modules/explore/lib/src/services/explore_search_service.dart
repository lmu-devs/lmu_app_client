class ExploreSearchService {
  // final _sportsCubit = GetIt.I.get<MensaCubit>();
  // final _mensaRepository = GetIt.I.get<ExploreRespos>();

  // List<MensaModel> _recentSearches = [];

  // List<MensaModel> get recentSearches => _recentSearches;

  // List<MensaModel> _mensaModels = [];

  // StreamSubscription? _cubitSubscription;

  // List<MensaModel> get mensaModels => _mensaModels;

  // void _updateRecentSearch(List<String> recentSearch) {
  //   _recentSearches = _mensaModels.where((mensaModel) => recentSearch.contains(mensaModel.canteenId)).toSet().toList()
  //     ..sort((a, b) => recentSearch.indexOf(a.name).compareTo(recentSearch.indexOf(b.name)));
  // }

  // void init() {
  //   _cubitSubscription = _sportsCubit.stream.withInitialValue(_sportsCubit.state).listen((state) {
  //     if (state is MensaLoadSuccess) {
  //       _mensaModels = state.mensaModels;
  //       _mensaRepository.getRecentSearches().then((recentSearch) {
  //         _updateRecentSearch(recentSearch);
  //       });

  //       final popularMensa = List.of(_mensaModels);
  //       popularMensa.sort((a, b) => b.ratingModel.likeCount.compareTo(a.ratingModel.likeCount));
  //       _popularMensaModels = popularMensa.take(3).toList();
  //     }
  //   });
  // }

  // void dispose() {
  //   _cubitSubscription?.cancel();
  // }

  Future<void> updateRecentSearch(List<String> recentSearch) async {
    // if (_recentSearches.map((search) => search.canteenId).toList() == recentSearch) return;
    // _updateRecentSearch(recentSearch);
    // await _mensaRepository.saveRecentSearches(recentSearch);
  }
}
