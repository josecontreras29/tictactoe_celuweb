import '../../../login/domain/entities/data_usuario.dart';
import '../../domain/entities/save_data_usuario_status.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/home_datasource.dart';

class HomeImpl implements HomeRepository {
  final HomeDataSource localDataSource;

  HomeImpl({required this.localDataSource});
  @override
  Future<SaveDataUsuarioStatus> saveDataUsuario(DataUsuario dataUsuario)async {
     try {
      return await localDataSource.saveDataUsuario(dataUsuario);
    } catch (error) {
      throw error.toString();
    }
  }
  
  @override
  Future<DataUsuario> getDataUsuarioTablero(int codigo)async {
    try {
      return await localDataSource.getDataUsuarioTablero(codigo);
    } catch (error) {
      throw error.toString();
    }
  }
}
