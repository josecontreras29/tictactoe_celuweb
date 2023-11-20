import '../../domain/entities/data_usuario.dart';

class LoginState {
  LoginState();
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoggedState extends LoginState {
  final DataUsuario dataUsuario;
  LoginLoggedState({required this.dataUsuario});
}
