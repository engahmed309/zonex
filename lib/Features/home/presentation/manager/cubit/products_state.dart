part of 'products_cubit.dart';

@immutable
sealed class ProductsState {
  const ProductsState();
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

final class ProductsSuccess extends ProductsState {
  final ProductsModelList productsList;
  const ProductsSuccess(this.productsList);
}

final class ProductsFailed extends ProductsState {
  final String errorMessage;
  const ProductsFailed(this.errorMessage);
}
