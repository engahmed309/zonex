import 'package:flutter/material.dart';

class HomeProductsGrid extends StatelessWidget {
  const HomeProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => Container(color: Colors.amber),
    );
  }
}
