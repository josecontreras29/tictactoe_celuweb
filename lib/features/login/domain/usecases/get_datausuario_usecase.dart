import '../../../-core/params/login_params.dart';
import '../../../-core/usecases/usecase.dart';
import '../entities/data_usuario.dart';
import '../repositories/login_repository.dart';

class GetDataUsuario extends UseCase<DataUsuario, LoginParams> {
  final LoginRepository repository;
  GetDataUsuario({required this.repository});
  @override
  Future<DataUsuario> call(LoginParams params) async {
    return await repository.getDataUsuario(params);
  }
}
