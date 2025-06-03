import 'package:zonex/Features/auth/login/data/models/login_model/login_model.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';

import 'base_response/general_response.dart';
import 'net_response.dart';

class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (T.toString() == "BaseResponse") {
      return BaseResponse.fromJson(json) as T;
    } else if (T.toString() == "GeneralResponse") {
      return GeneralResponse.fromJson(json) as T;
    } else if (T.toString() == "LoginModel") {
      return LoginModel.fromJson(json) as T;
    } else if (T.toString() == "ProductsModel") {
      return ProductsModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
