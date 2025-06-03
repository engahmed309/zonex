import 'package:flutter/material.dart';
import 'package:zonex/core/utils/helper.dart';

class NewArrivalsList extends StatelessWidget {
  const NewArrivalsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * .2,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: context.locale.isEnLocale ? 0 : 10,
            right: context.locale.isEnLocale ? 10 : 0,
          ),
          child: Container(
            color: Colors.amber,
            width: context.screenWidth * .6,
            height: context.screenHeight * .15,
            //  margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(child: Text('text $index')),
          ),
        ),
      ),
    );
  }
}
