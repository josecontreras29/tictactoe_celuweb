import '../../../-core/params/login_params.dart';
import '../entities/data_usuario.dart';

abstract class LoginRepository {
  Future<DataUsuario> getDataUsuario(LoginParams data);
}
