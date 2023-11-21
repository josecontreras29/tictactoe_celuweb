import '../../../-core/datasources/sqlite.dart';
import '../../../login/domain/entities/data_usuario.dart';
import '../models/get_data_usuario_tablero.dart';
import '../models/save_data_usuario_model.dart';

abstract class HomeDataSource {
  Future<SaveDataUsuarioModel> saveDataUsuario(DataUsuario dataUsuario);
  Future<GetDataUsuarioModel> getDataUsuarioTablero(int codigo);
}

class HomeDataSourceImpl implements HomeDataSource {
  final ClientSQLite client;

  HomeDataSourceImpl({required this.client});
  @override
  Future<SaveDataUsuarioModel> saveDataUsuario(DataUsuario dataUsuario) async {
    final db = await client.database;
    try {
      final response = await db.rawQuery(
          """UPDATE DataUsuario SET partidasJugadas = '${dataUsuario.partidasJugadas}',
      victorias= '${dataUsuario.victorias}',derrotas= '${dataUsuario.derrotas}'
      WHERE codigo = ${dataUsuario.codigo};""");

      /// EXAMPLE DELAY
      await Future.delayed(const Duration(milliseconds: 500));
      return SaveDataUsuarioModel.fromJson({'saved': response.isEmpty});
    } catch (error) {
      throw Exception("$error");
    }
  }

  @override
  Future<GetDataUsuarioModel> getDataUsuarioTablero(int codigo) async {
    final db = await client.database;
    try {
      final response = await db
          .rawQuery("""SELECT * FROM DataUsuario WHERE codigo = $codigo;""");

      /// EXAMPLE DELAY
      await Future.delayed(const Duration(milliseconds: 500));
      return GetDataUsuarioModel.fromJson(response[0]);
    } catch (error) {
      throw Exception("$error");
    }
  }
}
