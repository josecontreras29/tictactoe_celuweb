import '../../../-core/usecases/usecase.dart';
import '../../../login/domain/entities/data_usuario.dart';
import '../entities/save_data_usuario_status.dart';
import '../repositories/home_repository.dart';

class SaveDataUsuarioUseCase
    extends UseCase<SaveDataUsuarioStatus, DataUsuario> {
  final HomeRepository repository;
  SaveDataUsuarioUseCase({required this.repository});
  @override
  Future<SaveDataUsuarioStatus> call(DataUsuario params) async {
    return await repository.saveDataUsuario(params);
  }
}
