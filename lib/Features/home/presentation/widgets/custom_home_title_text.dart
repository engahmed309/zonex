import 'package:flutter/material.dart';
import 'package:zonex/core/utils/constants.dart';
import 'package:zonex/core/utils/helper.dart';

class CustomHomeTitleText extends StatelessWidget {
  const CustomHomeTitleText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.screenHeight * .01),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: context.screenWidth * 0.04,
          color: kSettingIconsColor,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
