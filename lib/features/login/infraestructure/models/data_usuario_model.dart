import '../../domain/entities/data_usuario.dart';

class DataUsuarioModel extends DataUsuario {
  DataUsuarioModel(
      {required super.codigo,
      required super.nombre,
      required super.partidasJugadas,
      required super.victorias,
      required super.derrotas});

  factory DataUsuarioModel.fromJson(Map<String, dynamic> json) {
    return DataUsuarioModel(
        codigo: json["codigo"],
        nombre: json["nombre"],
        partidasJugadas: json["partidasJugadas"] ?? 0,
        victorias: json["victorias"] ?? 0,
        derrotas: json["derrotas"] ?? 0);
  }
}
