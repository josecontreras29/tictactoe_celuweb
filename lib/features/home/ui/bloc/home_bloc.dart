import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../-core/datasources/check_status_game.dart';
import '../../../login/domain/entities/data_usuario.dart';
import '../../domain/usecases/get_data_usuario_tablero_usecase.dart';
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
    emit(HomeUpdatedTableroState(dataUsuario: getDataUsuarioTablero));
  }

  FutureOr<void> homeCheckGameIsCompletedEvent(
      HomeCheckGameIsCompletedEvent event, Emitter<HomeState> emit) {
        
    /// ALGORITMO DE FUERZA BRUTA - BACKTRACKING ///
    CheckStatusGame checkStatusGame =
        CheckStatusGame(listaCeldas: event.listaCeldas);
    DatosGanador checkHorizontals = checkStatusGame.verifyHorizontals();
    DatosGanador checkVerticals = checkStatusGame.verifyVerticals();
    DatosGanador checkDiagonals = checkStatusGame.verifyDiagonals();
    bool checkEmpate = checkStatusGame.verifyEmpate();
    if (checkHorizontals.winner != Player.none) {
      emit(HomeGameCompletedState(
          listWinnersIndex: checkHorizontals.celdasGanadoras,
          winner: checkHorizontals.winner));
    } else if (checkVerticals.winner != Player.none) {
      emit(HomeGameCompletedState(
          listWinnersIndex: checkVerticals.celdasGanadoras,
          winner: checkVerticals.winner));
    } else if (checkDiagonals.winner != Player.none) {
      emit(HomeGameCompletedState(
          listWinnersIndex: checkDiagonals.celdasGanadoras,
          winner: checkDiagonals.winner));
    } else if (checkEmpate) {
      emit(HomeEmpateState(winner: Player.none));
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

  FutureOr<void> homeChangeTurnEvent(
      HomeChangeTurnEvent event, Emitter<HomeState> emit) {
    emit(HomeChangeTurnState(player: event.player));
  }
}
