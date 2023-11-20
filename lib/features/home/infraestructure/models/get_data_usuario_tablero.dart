import '../../../login/domain/entities/data_usuario.dart';

class GetDataUsuarioModel extends DataUsuario {
  GetDataUsuarioModel(
      {required super.codigo,
      required super.nombre,
      required super.partidasJugadas,
      required super.victorias,
      required super.derrotas});

  factory GetDataUsuarioModel.fromJson(Map<String, dynamic> json) {
    return GetDataUsuarioModel(
        codigo: json["codigo"],
        nombre: json["nombre"],
        partidasJugadas: json["partidasJugadas"] ?? 0,
        victorias: json["victorias"] ?? 0,
        derrotas: json["derrotas"] ?? 0);
  }
}
