import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCubit extends Cubit<bool> {
  late final StreamSubscription _subscription;
  InternetCubit() : super(true) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      emit(connectivityResult != ConnectivityResult.none);
    });
  }

  emitInternetAvailability() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    emit(connectivityResult != ConnectivityResult.none);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
