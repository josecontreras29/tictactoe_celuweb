import '../../domain/entities/data_usuario.dart';

class LoginState {
  LoginState();
}

class LoginInitial extends LoginState {}

class Loading extends LoginState {}

class Logged extends LoginState {
  final DataUsuario dataUsuario;

  Logged({required this.dataUsuario});
}