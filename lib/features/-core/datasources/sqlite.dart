import 'dart:io';
import 'package:flutter/services.dart';
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

    bool exists = await databaseExists(path);
    if (!exists) {
      // SE CREA LA DB CON LA COPIA EN ASSETS //
      try {
        await Directory(dirname(path)).create(recursive: true);
        // ignore: empty_catches
      } catch (e) {}
      ByteData data =
          await rootBundle.load(url.join("assets", "DataBase_CeluWeb.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
    // SE ABRE LA DB //

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

