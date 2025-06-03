import 'package:flutter/material.dart';
import 'package:zonex/core/utils/helper.dart';

import '../utils/assets.dart';
import '../utils/constants.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  const CustomListTile({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: context.screenWidth * 0.04,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          color: kBottomNavIconsColor,
          fontSize: context.screenWidth * 0.04,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(AssetsData.logo),
      ),
    );
  }
}
