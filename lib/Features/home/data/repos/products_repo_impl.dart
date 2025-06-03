import 'package:zonex/Features/home/data/data_source/products_remote_data_source.dart';
import 'package:zonex/Features/home/domain/repos/products_repo.dart';

class ProductsRepoImpl extends ProductsRepo {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepoImpl(this.productsRemoteDataSource);

  @override
  Future<ProductsResponse> fetchProducts() async {
    var products = await productsRemoteDataSource.fetchProducts();
    return products;
  }
}
