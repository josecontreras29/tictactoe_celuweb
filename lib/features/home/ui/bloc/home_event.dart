import '../../../login/domain/entities/data_usuario.dart';
import '../reusable_widgets.dart/celda_matriz_juego.dart';
import '../views/home_view.dart';

class HomeEvent {
  HomeEvent();
}

class HomeInitialEvent extends HomeEvent {}

class HomeInitialDataEvent extends HomeEvent {
  final DataUsuario dataUsuario;
  HomeInitialDataEvent({required this.dataUsuario});
}

class HomeUpdateDataTableroEvent extends HomeEvent {
  final int codigo;
  HomeUpdateDataTableroEvent({required this.codigo});
}

class HomeCheckGameIsCompletedEvent extends HomeEvent {
  final List<CeldaMatriz> listaCeldas;
  HomeCheckGameIsCompletedEvent({required this.listaCeldas});
}

class HomeSaveDataUsuarioEvent extends HomeEvent {
  final DataUsuario actualDataUsuario;
  final Player winner;
  HomeSaveDataUsuarioEvent(
      {required this.actualDataUsuario, required this.winner});
}

class HomeChangeTurnEvent extends HomeEvent {
  final Player player;
  HomeChangeTurnEvent({required this.player});
}

class HomeClearListCellsEvent extends HomeEvent {}
