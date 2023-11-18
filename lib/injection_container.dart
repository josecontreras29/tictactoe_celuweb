import 'package:get_it/get_it.dart';
import 'package:tictactoe_celuweb/features/home/ui/bloc/imports_home_bloc.dart';

import 'features/-core/datasources/sqlite.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/get_datausuario.dart';
import 'features/login/infraestructure/datasource/login_datasource.dart';
import 'features/login/infraestructure/repositories/login_impl.dart';
import 'features/login/ui/bloc/imports_login_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // SQLITE
  sl.registerSingleton<ClientSQLite>(ClientSQLite());
// Dependencies
  sl.registerSingleton<LoginDataSource>(LoginDataSourceImpl(client: sl()));

  sl.registerSingleton<LoginRepository>(LoginImpl(localDataSource: sl()));
  // UseCases
  sl.registerSingleton<GetDataUsuario>(GetDataUsuario(repository: sl()));
  // Blocs
  sl.registerSingleton<LoginBloc>(LoginBloc(getDataUsuario: sl()));
  sl.registerSingleton<HomeBloc>(HomeBloc());
}
