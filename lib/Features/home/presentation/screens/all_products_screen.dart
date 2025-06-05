import 'package:flutter/material.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';
import 'package:zonex/Features/home/presentation/widgets/home_products_grid.dart';
import 'package:zonex/Features/home/presentation/widgets/products_search_delegates.dart';
import 'package:zonex/core/utils/constants.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key, required this.allProducts});
  final List<ProductsModel> allProducts;

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  String? selectedCategory;

  List<String> get categories {
    return widget.allProducts
        .map((product) => product.category!)
        .toSet()
        .toList();
  }

  List<ProductsModel> get filteredProducts {
    if (selectedCategory == null || selectedCategory == "All") {
      return widget.allProducts;
    } else {
      return widget.allProducts
          .where((product) => product.category == selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        title: Text('All Products ${filteredProducts.length}'),
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
                delegate: ProductSearchDelegate(widget.allProducts),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Dropdown filter
            DropdownButton<String>(
              value: selectedCategory,
              hint: const Text("Filter by category"),
              isExpanded: true,
              items: [
                const DropdownMenuItem(value: "All", child: Text("All")),
                ...categories.map(
                  (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 10),
            // Filtered grid
            Expanded(
              child: HomeProductsGrid(
                products: filteredProducts,
                isAllProducts: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
