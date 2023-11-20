import '../../../login/domain/entities/data_usuario.dart';
import '../entities/save_data_usuario_status.dart';

abstract class HomeRepository {
  Future<SaveDataUsuarioStatus> saveDataUsuario(DataUsuario dataUsuario);
  Future<DataUsuario> getDataUsuarioTablero(int codigo);
}
