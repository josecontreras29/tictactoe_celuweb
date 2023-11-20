import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ClientSQLite {
  static late Database _database;
  Future<Database> get database async {
    _database = await initDataBase();
    return _database;
  }

  initDataBase() async {
    String path = join(await getDatabasesPath(), "DataBase_CeluWeb.db");
    return await openDatabase(
      version: 2,
      path,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE DataUsuario(codigo INTEGER PRIMARY KEY, nombre TEXT, partidasJugadas INTEGER,victorias INTEGER,derrotas INTEGER)');
      },
    );
  }
}
