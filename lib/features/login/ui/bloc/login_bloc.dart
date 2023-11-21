import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../-core/params/login_params.dart';
import '../../domain/usecases/get_datausuario_usecase.dart';
import 'imports_login_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required GetDataUsuario getDataUsuario})
      : _getDataUsuario = getDataUsuario,
        super(LoginInitialState()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<LoginSignInEvent>(loginSignInEvent);
  }
  final GetDataUsuario _getDataUsuario;

  FutureOr<void> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) {}

  FutureOr<void> loginSignInEvent(
      LoginSignInEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final dataUsuario = await _getDataUsuario
        .call(LoginParams(code: event.codigo, name: event.nombre));
    emit(LoginLoggedState(dataUsuario: dataUsuario));
  }
}
