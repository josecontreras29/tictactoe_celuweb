import '../views/home_view.dart';

class HomeState {
  HomeState();
}

class HomeInitial extends HomeState {}

class Loading extends HomeState {}

class UpdatedTablero extends HomeState {
  final Players player;
  final int partidasJugadas;

  UpdatedTablero({required this.player, required this.partidasJugadas});
}
