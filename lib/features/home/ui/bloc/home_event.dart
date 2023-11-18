// ignore_for_file: file_names

import '../views/home_view.dart';

class HomeEvent {
  HomeEvent();
}

class InitialEventHome extends HomeEvent {}

class UpdateDataTablero extends HomeEvent {
  final Players player;
  final int partidasJugadas;

  UpdateDataTablero({required this.player, required this.partidasJugadas});
}
