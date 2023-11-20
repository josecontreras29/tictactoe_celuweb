import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_celuweb/features/home/domain/usecases/get_data_usuario_tablero_usecase.dart';

import '../../../login/domain/entities/data_usuario.dart';
import '../../domain/usecases/save_data_usuario_usecase.dart';
import '../views/home_view.dart';
import 'imports_home_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
      {required SaveDataUsuarioUseCase saveDataUsuarioCase,
      required GetDataUsuarioTableroUseCase getDataUsuarioTableroUseCase})
      : _saveDataUsuarioUsecase = saveDataUsuarioCase,
        _getDataUsuarioTableroUseCase = getDataUsuarioTableroUseCase,
        super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeInitialDataEvent>(homeInitialDataEvent);
    on<HomeUpdateDataTableroEvent>(homeUpdateDataTableroEvent);
    on<HomeCheckGameIsCompletedEvent>(homeCheckGameIsCompletedEvent);
    on<HomeUpdateDataUsuarioEvent>(homeUpdateDataUsuarioEvent);
    on<HomeChangeTurnEvent>(homeChangeTurnEvent);
  }

  final SaveDataUsuarioUseCase _saveDataUsuarioUsecase;
  final GetDataUsuarioTableroUseCase _getDataUsuarioTableroUseCase;

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {}

  FutureOr<void> homeInitialDataEvent(
      HomeInitialDataEvent event, Emitter<HomeState> emit) {
    emit(HomeInitialDataState(dataUsuario: event.dataUsuario));
  }

  FutureOr<void> homeUpdateDataTableroEvent(
      HomeUpdateDataTableroEvent event, Emitter<HomeState> emit) async {
    final getDataUsuarioTablero =
        await _getDataUsuarioTableroUseCase.call(event.codigo);
    emit(HomeUpdatedTableroState(dataUsuario: getDataUsuarioTablero  ));
  }

  FutureOr<void> homeCheckGameIsCompletedEvent(
      HomeCheckGameIsCompletedEvent event, Emitter<HomeState> emit) {
    /// ALGORITMO DE FUERZA BRUTA - BACKTRACKING ///
    List<int> listWinnersIndex = [];
    for (int i = 0; i < 9; i++) {
      if (i % 3 == 0) {
        if ((event.listaCeldas[i].actualValue == Player.player &&
            event.listaCeldas[i + 1].actualValue == Player.player &&
            event.listaCeldas[i + 2].actualValue == Player.player)) {
          listWinnersIndex.addAll([i, i + 1, i + 2]);
          emit(HomeGameCompletedState(
              listWinnersIndex: listWinnersIndex, winner: Player.player));
        } else if (event.listaCeldas[i].actualValue == Player.cpu &&
            event.listaCeldas[i + 1].actualValue == Player.cpu &&
            event.listaCeldas[i + 2].actualValue == Player.cpu) {
          listWinnersIndex.addAll([i, i + 1, i + 2]);
          emit(HomeGameCompletedState(
              listWinnersIndex: listWinnersIndex, winner: Player.cpu));
        }
      }
    }
    for (int i = 0; i < 3; i++) {
      if ((event.listaCeldas[i].actualValue == Player.player &&
          event.listaCeldas[i + 3].actualValue == Player.player &&
          event.listaCeldas[i + 6].actualValue == Player.player)) {
        listWinnersIndex.addAll([i, i + 3, i + 6]);
        emit(HomeGameCompletedState(
            listWinnersIndex: listWinnersIndex, winner: Player.player));
      } else if (event.listaCeldas[i].actualValue == Player.cpu &&
          event.listaCeldas[i + 3].actualValue == Player.cpu &&
          event.listaCeldas[i + 6].actualValue == Player.cpu) {
        listWinnersIndex.addAll([i, i + 3, i + 6]);
        emit(HomeGameCompletedState(
            listWinnersIndex: listWinnersIndex, winner: Player.cpu));
      }
    }
    if ((event.listaCeldas[0].actualValue == Player.player &&
        event.listaCeldas[4].actualValue == Player.player &&
        event.listaCeldas[8].actualValue == Player.player)) {
      listWinnersIndex.addAll([0, 4, 8]);
      emit(HomeGameCompletedState(
          listWinnersIndex: listWinnersIndex, winner: Player.player));
    } else if (event.listaCeldas[0].actualValue == Player.cpu &&
        event.listaCeldas[4].actualValue == Player.cpu &&
        event.listaCeldas[8].actualValue == Player.cpu) {
      listWinnersIndex.addAll([0, 4, 8]);
      emit(HomeGameCompletedState(
          listWinnersIndex: listWinnersIndex, winner: Player.cpu));
    }
    if ((event.listaCeldas[2].actualValue == Player.player &&
        event.listaCeldas[4].actualValue == Player.player &&
        event.listaCeldas[6].actualValue == Player.player)) {
      listWinnersIndex.addAll([2, 4, 6]);
      emit(HomeGameCompletedState(
          listWinnersIndex: listWinnersIndex, winner: Player.player));
    } else if (event.listaCeldas[2].actualValue == Player.cpu &&
        event.listaCeldas[4].actualValue == Player.cpu &&
        event.listaCeldas[6].actualValue == Player.cpu) {
      listWinnersIndex.addAll([2, 4, 6]);
      emit(HomeGameCompletedState(
          listWinnersIndex: listWinnersIndex, winner: Player.cpu));
    }
  }

  FutureOr<void> homeUpdateDataUsuarioEvent(
      HomeUpdateDataUsuarioEvent event, Emitter<HomeState> emit) async {
    DataUsuario newDataUser = DataUsuario(
        codigo: event.actualDataUsuario.codigo,
        nombre: event.actualDataUsuario.nombre,
        partidasJugadas: event.actualDataUsuario.partidasJugadas + 1,
        victorias: event.winner == Player.player
            ? event.actualDataUsuario.victorias + 1
            : event.actualDataUsuario.victorias,
        derrotas: event.winner == Player.cpu
            ? event.actualDataUsuario.derrotas + 1
            : event.actualDataUsuario.derrotas);
    final dataSaved = await _saveDataUsuarioUsecase.call(newDataUser);
    if (dataSaved.saved) {
      emit(HomeUpdateDataUsuarioState());
    }
  }

  FutureOr<void> homeChangeTurnEvent(HomeChangeTurnEvent event, Emitter<HomeState> emit) {
    emit(HomeChangeTurnState(player: event.player));
  }
}
