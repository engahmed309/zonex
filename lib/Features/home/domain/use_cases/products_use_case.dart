import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';
import 'package:zonex/Features/home/data/data_source/products_remote_data_source.dart';
import 'package:zonex/Features/home/domain/repos/products_repo.dart';

abstract class UseCase<type> {
  Future<ProductsResponse> call();
}

class ProductsUseCase extends UseCase<LoginEntity> {
  final ProductsRepo productsRepo;
  ProductsUseCase(this.productsRepo);

  @override
  Future<ProductsResponse> call() async {
    return await productsRepo.fetchProducts();
  }
}
