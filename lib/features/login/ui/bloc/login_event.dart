class LoginEvent {
  LoginEvent();
}

class LoginInitialEvent extends LoginEvent {}

class LoginSignInEvent extends LoginEvent {
  final int codigo;
  final String nombre;
  LoginSignInEvent({required this.codigo, required this.nombre});
}
