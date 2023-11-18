import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../-core/params/login_params.dart';
import '../../domain/usecases/get_datausuario.dart';
import 'imports_login_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required GetDataUsuario getDataUsuario})
      : _getDataUsuario = getDataUsuario,
        super(LoginInitial()) {
    on<InitialEventLogin>(initialEventLogin);
    on<SignIn>(signIn);
  }
  final GetDataUsuario _getDataUsuario;
  FutureOr<void> initialEventLogin(
      InitialEventLogin event, Emitter<LoginState> emit) {}

  FutureOr<void> signIn(SignIn event, Emitter<LoginState> emit) async {
    emit(Loading());
    final dataUsuario = await _getDataUsuario
        .call(LoginParams(code: event.codigo, name: event.nombre));
    emit(Logged(dataUsuario: dataUsuario));
  }
}
