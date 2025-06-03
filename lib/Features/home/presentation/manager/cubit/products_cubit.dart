import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';
import 'package:zonex/Features/home/domain/use_cases/products_use_case.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.productRequest) : super(ProductsInitial());
  final ProductsUseCase productRequest;

  Future<void> getProducts() async {
    emit(const ProductsLoading());
    final result = await productRequest.call();

    emit(result.fold(ProductsFailed.new, ProductsSuccess.new));
  }
}
