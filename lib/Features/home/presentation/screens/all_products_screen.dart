import 'package:flutter/material.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';
import 'package:zonex/Features/home/presentation/widgets/home_products_grid.dart';
import 'package:zonex/Features/home/presentation/widgets/products_search_delegates.dart';
import 'package:zonex/core/utils/constants.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, required this.allProducts});
  final List<ProductsModel> allProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        title: Text('All Products ${allProducts.length}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: kPrimaryColor),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(allProducts),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HomeProductsGrid(products: allProducts, isAllProducts: true),
      ),
    );
  }
}
