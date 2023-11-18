
import '../../../-core/datasources/sqlite.dart';
import '../../../-core/params/login_params.dart';
import '../models/data_usuario_model.dart';

abstract class LoginDataSource {
  Future<DataUsuarioModel> getDataUsuario(LoginParams data);
}

class LoginDataSourceImpl implements LoginDataSource {
  final ClientSQLite client;

  LoginDataSourceImpl({required this.client});
  @override
  Future<DataUsuarioModel> getDataUsuario(LoginParams data) async {
    final db = await client.database;
    try {
      List<Map<String, dynamic>> response = await db.rawQuery(
          "SELECT * FROM DataUsuario where Codigo LIKE '%${data.code}%'");
      if (response.isEmpty) {
        await db.rawQuery(
            """INSERT INTO DataUsuario (codigo, nombre, partidasJugadas, victorias, derrotas) 
            VALUES ('${data.code}','${data.name}',NULL,NULL,NULL);""");
        response = await db.rawQuery(
            """SELECT * FROM DataUsuario where Codigo LIKE '%${data.code}%'""");
      }
      return DataUsuarioModel.fromJson(response[0]);
    } catch (error) {
      throw Exception("$error");
    }
  }
}
