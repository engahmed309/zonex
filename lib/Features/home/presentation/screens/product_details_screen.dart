import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';
import 'package:zonex/core/utils/commons.dart';
import 'package:zonex/core/utils/constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductsModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  int quantity = 1;
  bool isAddingToCart = false;
  bool isUpdatingCart = false;

  double get discountedPrice =>
      widget.product.price! -
      (widget.product.price! * widget.product.discount! / 100);

  Future<void> addToCart() async {
    try {
      setState(() => isAddingToCart = true);

      final userBox = await Hive.openBox<LoginEntity>(kUserDataBox);
      final user = userBox.getAt(0);

      if (user == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }

      final existingItem = await supabase
          .from('cart')
          .select()
          .eq('product_id', widget.product.id.toString())
          .eq('user_id', user.id.toString())
          .maybeSingle();

      if (existingItem != null) {
        await supabase
            .from('cart')
            .update({'quantity': existingItem['quantity'] + quantity})
            .eq('id', existingItem['id']);
      } else {
        await supabase.from('cart').insert({
          'product_id': widget.product.id,
          'user_id': user.id,
          'quantity': quantity,
          'created_at': DateTime.now().toIso8601String(),
        });
      }

      Commons.showToast(
        context,
        message: 'Product added to cart',
        color: Colors.green,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ: ${e.toString()}')));
    } finally {
      setState(() => isAddingToCart = false);
    }
  }

  Widget _buildQuantitySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline, size: 30),
          onPressed: () {
            if (quantity > 1) {
              setState(() => quantity--);
            }
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 18),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline, size: 30),
          onPressed: () {
            setState(() => quantity++);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        title: Text(widget.product.name ?? 'تفاصيل المنتج'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
                  widget.product.image ?? '',
                  // fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.image_not_supported, size: 50),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              widget.product.name ?? '',
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
                if (widget.product.discount! > 0)
                  Text(
                    "\$${widget.product.price!.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                if (widget.product.discount! > 0) const SizedBox(width: 6),
                if (widget.product.discount! > 0)
                  Text(
                    "-${widget.product.discount}%",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            _buildQuantitySelector(),

            const SizedBox(height: 20),

            Text(
              widget.product.description ?? 'لا يوجد وصف لهذا المنتج.',
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
                onPressed: isAddingToCart ? null : addToCart,
                child: isAddingToCart
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
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
