import '../../../-core/usecases/usecase.dart';
import '../../../login/domain/entities/data_usuario.dart';
import '../repositories/home_repository.dart';

class GetDataUsuarioTableroUseCase
    extends UseCase<DataUsuario, int> {
  final HomeRepository repository;
  GetDataUsuarioTableroUseCase({required this.repository});
  @override
  Future<DataUsuario> call(int params) async {
    return await repository.getDataUsuarioTablero(params);
  }
}
