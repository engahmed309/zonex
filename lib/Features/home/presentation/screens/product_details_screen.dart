import 'package:flutter/material.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';
import 'package:zonex/core/utils/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    final double discountedPrice =
        product.price! - (product.price! * product.discount! / 100);

    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        title: Text(product.name ?? 'تفاصيل المنتج'),
        //Add a back button to the app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Center(child: Icon(Icons.image_not_supported, size: 50)),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // اسم المنتج
            Text(
              product.name ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Text(
                  "\$${discountedPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(width: 10),
                if (product.discount! > 0)
                  Text(
                    "\$${product.price!.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                if (product.discount! > 0) const SizedBox(width: 6),
                if (product.discount! > 0)
                  Text(
                    "-${product.discount}%",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              product.description ?? 'لا يوجد وصف لهذا المنتج.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إضافة المنتج إلى السلة')),
                  );
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
