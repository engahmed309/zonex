import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:zonex/Features/auth/login/data/models/login_model/login_model.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';

import '../../../../../../../../core/utils/network/network_request.dart';
import '../../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../../core/utils/network/network_utils.dart';

typedef RegisterResponse = Either<String, LoginEntity>;

abstract class AddUserRemoteDataSource {
  Future<RegisterResponse> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required String email,
    required String password,
    required String confirmPassword,
  });
}

class AddUserRemoteDataSourceImpl extends AddUserRemoteDataSource {
  @override
  Future<RegisterResponse> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    RegisterResponse addUserResponse = left('');
    var formData = FormData();

    formData.fields.add(MapEntry("first_name", firstName));
    formData.fields.add(MapEntry("last_name", lastName));
    formData.fields.add(MapEntry("phone", phone));
    formData.fields.add(MapEntry("address", phone));
    formData.fields.add(MapEntry("email", email));
    formData.fields.add(MapEntry("password", password));

    // var body = {
    //   "user_name": userName,

    // };
    await getIt<NetworkRequest>().requestFutureData<LoginModel>(
      Method.post,
      formData: formData,
      isFormData: true,
      // params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: Api.doServerRegisterApiCall,
      onSuccess: (data) {
        if (data.state == true) {
          addUserResponse = right(data);
        } else {
          addUserResponse = left(data.message.toString());
        }
      },
      onError: (code, msg) {
        addUserResponse = left(msg);
      },
    );
    return addUserResponse;
  }
}
