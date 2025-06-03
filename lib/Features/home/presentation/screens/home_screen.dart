import 'package:flutter/material.dart';
import 'package:zonex/Features/home/presentation/widgets/custom_home_title_text.dart';
import 'package:zonex/Features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:zonex/Features/home/presentation/widgets/home_products_grid.dart';
import 'package:zonex/Features/home/presentation/widgets/new_arrivals_list.dart';
import 'package:zonex/core/utils/helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: [
                CustomHomeTitleText(title: "Featured Products"),

                Text("data"),
              ],
            ),
            HomeProductsGrid(),
            CustomHomeTitleText(title: "New Arrivals"),
            NewArrivalsList(),
          ],
        ),
      ),
    );
  }
}
