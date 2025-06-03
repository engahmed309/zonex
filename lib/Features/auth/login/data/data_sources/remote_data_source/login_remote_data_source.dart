import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:zonex/Features/auth/login/data/models/login_model/login_model.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../../../domain/entities/login_entity.dart';

typedef LoginResponse = Either<String, LoginEntity>;

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(String phone, String password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  @override
  Future<LoginResponse> login(String email, String password) async {
    LoginResponse loginResponse = left("");

    var body = {"email": email, "password": password};

    await getIt<NetworkRequest>().requestFutureData<LoginModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: Api.doServerLoginApiCall,
      onSuccess: (data) {
        if (data.state == true) {
          loginResponse = right(data);
        } else {
          loginResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        loginResponse = left('Error $code, Invalid input');
      },
    );
    return loginResponse;
  }
}
