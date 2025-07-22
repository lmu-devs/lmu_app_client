enum LoadState { initial, loading, loadingWithCache, success, genericError, noNetworkError }

extension LoadStateExtension on LoadState {
  bool get isLoading => this == LoadState.loading;

  bool get isSuccess => this == LoadState.success || this == LoadState.loadingWithCache;

  bool get isError => this == LoadState.genericError || this == LoadState.noNetworkError;

  bool get isGenericError => this == LoadState.genericError;

  bool get isNoNetworkError => this == LoadState.noNetworkError;

  bool get isInitial => this == LoadState.initial;

  bool get isLoadingOrSuccess =>
      this == LoadState.loading || this == LoadState.loadingWithCache || this == LoadState.success;
}
