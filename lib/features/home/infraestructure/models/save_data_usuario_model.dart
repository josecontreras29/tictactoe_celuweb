import '../../domain/entities/save_data_usuario_status.dart';

class SaveDataUsuarioModel extends SaveDataUsuarioStatus {
  SaveDataUsuarioModel({required super.saved});

  factory SaveDataUsuarioModel.fromJson(Map<String, dynamic> json) {
    return SaveDataUsuarioModel(saved: json["saved"]);
  }
}
