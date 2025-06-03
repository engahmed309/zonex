import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zonex/Features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:zonex/Features/home/presentation/widgets/custom_home_title_text.dart';
import 'package:zonex/Features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:zonex/Features/home/presentation/widgets/home_products_grid.dart';
import 'package:zonex/Features/home/presentation/widgets/new_arrivals_list.dart';
import 'package:zonex/core/utils/constants.dart';
import 'package:zonex/core/utils/helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context).getProducts();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * .04,
          //     vertical: context.screenHeight * .02,
        ),
        child: ListView(
          children: [
            CustomHomeTitleText(title: context.locale.translate("home")!),
            HomeCarouselSlider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomHomeTitleText(title: "Featured Products"),

                TextButton(
                  onPressed: () {},
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
                return state is ProductsSuccess
                    ? HomeProductsGrid(products: state.productsList)
                    : state is ProductsFailed
                    ? Text(state.errorMessage)
                    : const Center(child: CircularProgressIndicator());
              },
            ),
            CustomHomeTitleText(title: "New Arrivals"),
            NewArrivalsList(),
            SizedBox(height: context.screenHeight * .05),
          ],
        ),
      ),
    );
  }
}
