import '../../../-core/params/login_params.dart';
import '../../domain/entities/data_usuario.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasource/login_datasource.dart';

class LoginImpl implements LoginRepository {
  final LoginDataSource localDataSource;

  LoginImpl({required this.localDataSource});

  @override
  Future<DataUsuario> getDataUsuario(LoginParams data) async{
      try {
      return await localDataSource.getDataUsuario(data);
    } catch (error) {
      throw error.toString();
    }
  }
}
