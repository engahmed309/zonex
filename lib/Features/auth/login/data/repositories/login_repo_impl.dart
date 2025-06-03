import '../../domain/repositories/login_repo.dart';
import '../data_sources/remote_data_source/login_remote_data_source.dart';

class LoginRepoImpl extends LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepoImpl(this.loginRemoteDataSource);

  @override
  Future<LoginResponse> login(String phone, String password) async {
    var userData = await loginRemoteDataSource.login(phone, password);
    return userData;
  }

  // @override
  // Future<LoginResponse> login(String phone) async {
  //   Future<LoginResponse> logini(String phone) async {
  //     try {
  //       var userData = await loginRemoteDataSourec.login(phone);

  //       return right(userData);
  //     } catch (e) {
  //       return Left(ServerFailure(e.toString()));
  //     }
  //   }
  // }
}
