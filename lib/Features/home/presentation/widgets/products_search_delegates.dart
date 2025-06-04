import 'package:flutter/material.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';
import 'package:zonex/Features/home/presentation/screens/product_details_screen.dart';

class ProductSearchDelegate extends SearchDelegate {
  final List<ProductsModel> allProducts;

  ProductSearchDelegate(this.allProducts);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allProducts
        .where(
          (product) =>
              product.name!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text("No products found"));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          leading: Image.network(
            product.image ?? '',
            width: 50,
            height: 50,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
          title: Text(product.name ?? 'No Title'),
          subtitle: Text('${product.price ?? 0} EGP'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allProducts
        .where(
          (product) =>
              product.name!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.name ?? ''),
          onTap: () {
            query = product.name!;
            showResults(context);
          },
        );
      },
    );
  }
}
