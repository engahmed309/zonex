import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';

import '../../data/data_sources/remote_data_source/login_remote_data_source.dart';
import '../repositories/login_repo.dart';

abstract class UseCase<type> {
  Future<LoginResponse> call(String phone, String password);
}

class LoginUseCase extends UseCase<LoginEntity> {
  final LoginRepo loginRepo;
  LoginUseCase(this.loginRepo);

  @override
  Future<LoginResponse> call(String phone, String password) async {
    return await loginRepo.login(phone, password);
  }
}
