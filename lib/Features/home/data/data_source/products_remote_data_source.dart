import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';
import 'package:zonex/core/utils/network/api/network_api.dart';

typedef ProductsResponse = Either<String, List<ProductsModel>>;

abstract class ProductsRemoteDataSource {
  Future<ProductsResponse> fetchProducts();
}

class ProductsRemoteDataSourceImpl extends ProductsRemoteDataSource {
  final Dio dio;

  ProductsRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? Dio();

  @override
  Future<ProductsResponse> fetchProducts() async {
    try {
      final response = await dio.get(
        Api.doServerProductsApiCall,
        options: Options(contentType: Headers.jsonContentType),
      );

      print('Status code: ${response.statusCode}');
      print('Response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        if (response.data is List) {
          final List<dynamic> dataList = response.data;
          final products = dataList
              .map(
                (json) => ProductsModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
          return right(products);
        } else if (response.data is Map<String, dynamic> &&
            response.data.containsKey('data')) {
          // لو الريسبونس Map وفيه data جوهها (قائمة المنتجات)
          final dataList = response.data['data'];
          if (dataList is List) {
            final products = dataList
                .map(
                  (json) =>
                      ProductsModel.fromJson(json as Map<String, dynamic>),
                )
                .toList();
            return right(products);
          } else {
            return left('Response "data" is not a List');
          }
        } else {
          return left('Response is not a List or Map with data key');
        }
      } else {
        return left(
          'Error: Server responded with status code ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.statusMessage ?? e.message;
      return left('DioError: $errorMessage');
    } catch (e) {
      return left('Unexpected error: $e');
    }
  }
}
