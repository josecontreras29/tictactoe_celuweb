import '../../../login/domain/entities/data_usuario.dart';
import '../views/home_view.dart';

class HomeState {
  HomeState();
}

class HomeInitialState extends HomeState {}

class HomeInitialDataState extends HomeState {
  final DataUsuario dataUsuario;

  HomeInitialDataState({required this.dataUsuario});
}

class HomeLoadingState extends HomeState {}

class HomeUpdatedTableroState extends HomeState {
  final DataUsuario dataUsuario;

  HomeUpdatedTableroState({required this.dataUsuario});
}

class HomeGameCompletedState extends HomeState {
  final List<int> listWinnersIndex;
  final Player winner;
  HomeGameCompletedState(
      {required this.listWinnersIndex, required this.winner});
}

class HomeUpdateDataUsuarioState extends HomeState {}

class HomeChangeTurnState extends HomeState {
  final Player player;
  HomeChangeTurnState({required this.player});
}
