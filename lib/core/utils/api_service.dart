import 'package:dio/dio.dart';
import 'package:zonex/core/utils/network/api/network_api.dart';

class ApiService {
  final Dio _dio;

  final baseUrl = Api.baseUrl;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get('$baseUrl$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> pos({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
    var response = await _dio.post('$baseUrl$endPoint', queryParameters: body);
    return response.data;
  }
}
