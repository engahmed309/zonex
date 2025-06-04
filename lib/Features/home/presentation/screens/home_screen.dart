import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';
import 'package:zonex/Features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:zonex/Features/home/presentation/widgets/custom_home_title_text.dart';
import 'package:zonex/Features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:zonex/Features/home/presentation/widgets/home_products_grid.dart';
import 'package:zonex/Features/home/presentation/widgets/new_arrivals_list.dart';
import 'package:zonex/Features/home/presentation/widgets/products_search_delegates.dart';
import 'package:zonex/core/utils/constants.dart';
import 'package:zonex/core/utils/helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<ProductsModel>> fetchProductsFromSupabase() async {
    final data = await Supabase.instance.client.from('products').select();
    return data
        .map<ProductsModel>((item) => ProductsModel.fromJson(item))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context).getProducts();
    late Future<List<ProductsModel>> supaBaseProducts =
        fetchProductsFromSupabase();
    late List<ProductsModel> allProducts = [];
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .04),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomHomeTitleText(
                  title: context.locale.translate("top_products")!,
                ),
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
            const HomeCarouselSlider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomHomeTitleText(
                  title: context.locale.translate("featured_products")!,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      kAllProductsScreenRoute,
                      arguments: allProducts,
                    );
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: context.screenWidth * 0.04,
                      color: kPrimaryColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsSuccess) {
                  allProducts.addAll(state.productsList);
                  supaBaseProducts.then((value) => {allProducts.addAll(value)});

                  return HomeProductsGrid(
                    products: state.productsList,
                    isAllProducts: false,
                  );
                } else if (state is ProductsFailed) {
                  return Text(state.errorMessage);
                } else if (state is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Text("Unknown Error Occurred");
                }
              },
            ),
            CustomHomeTitleText(
              title: context.locale.translate("new_arrivals")!,
            ),
            NewArrivalsSection(products: supaBaseProducts),
            SizedBox(height: context.screenHeight * .05),
          ],
        ),
      ),
    );
  }
}
