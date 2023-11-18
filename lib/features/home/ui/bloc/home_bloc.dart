import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'imports_home_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitialEventHome>(initialEventHome);
    on<UpdateDataTablero>(updateDataTablero);
  }

  FutureOr<void> initialEventHome(
      InitialEventHome event, Emitter<HomeState> emit) {}

  FutureOr<void> updateDataTablero(
      UpdateDataTablero event, Emitter<HomeState> emit) {
    emit(UpdatedTablero(
        player: event.player, partidasJugadas: event.partidasJugadas));
  }
}
