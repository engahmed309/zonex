import 'package:zonex/Features/home/data/data_source/products_remote_data_source.dart';

abstract class ProductsRepo {
  Future<ProductsResponse> fetchProducts();
}
