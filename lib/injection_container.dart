import 'package:get_it/get_it.dart';

import 'features/-core/datasources/sqlite.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_data_usuario_tablero_usecase.dart';
import 'features/home/domain/usecases/save_data_usuario_usecase.dart';
import 'features/home/infraestructure/datasource/home_datasource.dart';
import 'features/home/infraestructure/repositories/home_impl.dart';
import 'features/home/ui/bloc/imports_home_bloc.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/get_datausuario_usecase.dart';
import 'features/login/infraestructure/datasource/login_datasource.dart';
import 'features/login/infraestructure/repositories/login_impl.dart';
import 'features/login/ui/bloc/imports_login_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // SQLITE
  sl.registerSingleton<ClientSQLite>(ClientSQLite());
// Dependencies
  sl.registerSingleton<LoginDataSource>(LoginDataSourceImpl(client: sl()));
  sl.registerSingleton<HomeDataSource>(HomeDataSourceImpl(client: sl()));

  sl.registerSingleton<LoginRepository>(LoginImpl(localDataSource: sl()));
  sl.registerSingleton<HomeRepository>(HomeImpl(localDataSource: sl()));
  // UseCases
  sl.registerSingleton<GetDataUsuario>(GetDataUsuario(repository: sl()));
  sl.registerSingleton<SaveDataUsuarioUseCase>(
      SaveDataUsuarioUseCase(repository: sl()));
  sl.registerSingleton<GetDataUsuarioTableroUseCase>(
      GetDataUsuarioTableroUseCase(repository: sl()));
  // Blocs
  sl.registerSingleton<LoginBloc>(LoginBloc(getDataUsuario: sl()));
  sl.registerSingleton<HomeBloc>(
      HomeBloc(saveDataUsuarioCase: sl(), getDataUsuarioTableroUseCase: sl()));
}
