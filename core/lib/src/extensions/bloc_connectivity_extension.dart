import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ConnectivityListener<T extends Cubit<S>, S> on T {
  void listenForConnectivityRestoration(void Function() onRestored) async {
    StreamSubscription? subscription;

    subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (!results.contains(ConnectivityResult.none)) {
        onRestored();
        subscription?.cancel();
      }
    });
  }
}
