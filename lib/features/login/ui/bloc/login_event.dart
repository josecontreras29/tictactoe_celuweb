class LoginEvent {
  LoginEvent();
}

class InitialEventLogin extends LoginEvent {}

class SignIn extends LoginEvent {
  final int codigo;
  final String nombre;

  SignIn({required this.codigo, required this.nombre});
}
