import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zonex/core/utils/helper.dart';

class HomeCarouselSlider extends StatelessWidget {
  const HomeCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: context.screenHeight * .2,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.amber),
              child: Center(
                child: Text('text $i', style: const TextStyle(fontSize: 24.0)),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
