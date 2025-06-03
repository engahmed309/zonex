import '../../data/data_sources/remote_data_source/login_remote_data_source.dart';

abstract class LoginRepo {
  Future<LoginResponse> login(String phone, String password);
}
