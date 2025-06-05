import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';
import 'package:zonex/core/utils/commons.dart';
import 'package:zonex/core/utils/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;
  bool isPlacingOrder = false;
  var user = Hive.box<LoginEntity>(kUserDataBox).getAt(0);

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      final product = findProduct(item['product_id']);
      if (product != null) {
        final price = product['price'] as num;
        final discount = product['discount'] as num;
        final quantity = item['quantity'] as num;
        total += (price - (price * discount / 100)) * quantity.toDouble();
      }
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    try {
      final currentUserId = user?.id;

      if (currentUserId == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final cartResponse = await supabase
          .from('cart')
          .select()
          .eq('user_id', currentUserId);

      cartItems = List<Map<String, dynamic>>.from(cartResponse);

      if (cartItems.isEmpty) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final productIds = cartItems
          .map((item) => item['product_id'] as int)
          .toList();

      final productsResponse = await supabase
          .from('products')
          .select()
          .inFilter('id', productIds);

      setState(() {
        products = List<Map<String, dynamic>>.from(productsResponse);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
    }
  }

  Future<void> removeFromCart(int cartItemId, int index) async {
    try {
      final currentUserId = user?.id;

      if (currentUserId == null) {
        throw Exception('المستخدم غير مسجل الدخول');
      }

      await supabase.from('cart').delete().match({
        'id': cartItemId,
        'user_id': currentUserId,
      });

      final productId = cartItems[index]['product_id'];

      setState(() {
        cartItems.removeAt(index);
        products.removeWhere((product) => product['id'] == productId);
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم حذف المنتج من السلة')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ في الحذف: ${e.toString()}')));
    }
  }

  Future<void> updateQuantity(int cartItemId, int newQuantity) async {
    try {
      await supabase
          .from('cart')
          .update({'quantity': newQuantity})
          .eq('id', cartItemId);

      setState(() {
        final index = cartItems.indexWhere((item) => item['id'] == cartItemId);
        if (index != -1) {
          cartItems[index]['quantity'] = newQuantity;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في تحديث الكمية: ${e.toString()}')),
      );
    }
  }

  Future<void> placeOrder() async {
    try {
      setState(() => isPlacingOrder = true);
      final currentUserId = user?.id;

      if (currentUserId == null) {
        throw Exception('المستخدم غير مسجل الدخول');
      }

      await supabase.from('orders').insert({
        'user_id': currentUserId,
        'total_amount': totalPrice.toInt(),
        'status': 'pending',
        'product_ids': cartItems
            .map((item) => item['product_id'])
            .toList()
            .toString(),
      }).select();

      await supabase.from('cart').delete().eq('user_id', currentUserId);

      setState(() {
        cartItems.clear();
        products.clear();
      });

      Commons.showToast(
        context,
        message: 'Order placed successfully!',
        color: Colors.green,
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في إنشاء الطلب: ${e.toString()}')),
      );
    } finally {
      setState(() => isPlacingOrder = false);
    }
  }

  Map<String, dynamic>? findProduct(int productId) {
    try {
      return products.firstWhere((product) => product['id'] == productId);
    } catch (e) {
      return null;
    }
  }

  Widget _buildCartItem(int index) {
    final cartItem = cartItems[index];
    final product = findProduct(cartItem['product_id']);
    final quantity = cartItem['quantity'] as int;

    if (product == null) return const SizedBox();

    final price = product['price'] as num;
    final discount = product['discount'] as num;
    final discountedPrice = price - (price * discount / 100);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                product['image'] != null
                    ? Image.network(
                        product['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image_not_supported, size: 80),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'] ?? 'اسم غير معروف',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (discount > 0)
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      Text(
                        '\$${discountedPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (discount > 0)
                        Text(
                          'خصم ${discount.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        if (quantity > 1) {
                          updateQuantity(cartItem['id'], quantity - 1);
                        }
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        updateQuantity(cartItem['id'], quantity + 1);
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('تأكيد الحذف'),
                        content: const Text('هل تريد حذف هذا المنتج من السلة؟'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('إلغاء'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('حذف'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await removeFromCart(cartItem['id'], index);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cartItems.isEmpty) {
      return const Center(
        child: Text('Your cart is empty', style: TextStyle(fontSize: 18)),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) => _buildCartItem(index),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الإجمالي:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isPlacingOrder ? null : placeOrder,
                  child: isPlacingOrder
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Place Order',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
