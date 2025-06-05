import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';
import 'package:zonex/core/utils/constants.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> orders = [];
  Map<int, String> productNames = {};
  bool isLoading = true;
  var user = Hive.box<LoginEntity>(kUserDataBox).getAt(0);

  @override
  void initState() {
    super.initState();
    fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    try {
      final currentUserId = user?.id;

      if (currentUserId == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final ordersResponse = await supabase
          .from('orders')
          .select()
          .eq('user_id', currentUserId)
          .order('created_at', ascending: false);

      setState(() {
        orders = List<Map<String, dynamic>>.from(ordersResponse);
      });

      final allProductIds = orders
          .map((order) => _parseProductIds(order['product_ids']))
          .expand((ids) => ids)
          .toSet()
          .toList();

      if (allProductIds.isNotEmpty) {
        final productsResponse = await supabase
            .from('products')
            .select('id, name')
            .inFilter('id', allProductIds);

        for (var product in productsResponse) {
          productNames[product['id'] as int] = product['name'] as String;
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ: ${e.toString()}')));
    }
  }

  List<int> _parseProductIds(String productIdsString) {
    try {
      return productIdsString
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map((id) => int.tryParse(id.trim()) ?? 0)
          .where((id) => id != 0)
          .toList();
    } catch (e) {
      return [];
    }
  }

  String _formatProducts(List<int> productIds) {
    final names = productIds.map((id) => productNames[id] ?? '').toList();
    final uniqueProducts = names.toSet().toList();

    if (uniqueProducts.isEmpty) return 'لا توجد منتجات';

    final productCounts = <String, int>{};
    for (var name in names) {
      productCounts[name] = (productCounts[name] ?? 0) + 1;
    }

    return uniqueProducts
        .map((name) {
          final count = productCounts[name]!;
          return count > 1 ? '$name (×$count)' : name;
        })
        .join('، ');
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    final productIds = _parseProductIds(order['product_ids'] ?? '[]');
    final productsText = _formatProducts(productIds);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          kOrderDetailsScreenRoute,
          arguments: order,
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${order['id']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Chip(
                    label: Text(
                      order['status'] ?? 'pending',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: _getStatusColor(
                      order['status'] ?? 'pending',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Products:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(productsText, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${order['total_amount']?.toStringAsFixed(2) ?? '0.00'}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (order['created_at'] != null)
                    Text(
                      DateTime.parse(
                        order['created_at'],
                      ).toString().substring(0, 10),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orders.isEmpty) {
      return const Center(
        child: Text('No orders found', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) => _buildOrderItem(orders[index]),
    );
  }
}
