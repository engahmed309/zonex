import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';
import 'package:zonex/core/utils/helper.dart';

import '../../../../core/utils/constants.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key, required this.tapHandler});
  final Function tapHandler;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<LoginEntity>(kUserDataBox);
    var imageBox = Hive.box(kUserImageBox);
    final String? imagePath = imageBox.get('image');
    return AppBar(
      // RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(context.screenWidth * .06),
          bottomStart: Radius.circular(context.screenWidth * .06),
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: false,
      shadowColor: Colors.grey,
      surfaceTintColor: Colors.white,
      elevation: 3,
      actionsIconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.locale.translate("welcome")!,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: context.screenWidth * .034,
              color: kGreyTextColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            box.getAt(0)!.firstName,
            style: TextStyle(
              fontSize: context.screenWidth * .045,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      leading: imagePath != null
          ? CircleAvatar(backgroundImage: FileImage(File(imagePath)))
          : Padding(
              padding: EdgeInsets.all(context.screenWidth * .01),
              child: CircleAvatar(
                backgroundColor: kBottomNavIconsColor,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
      actions: [
        InkWell(
          onTap: () {
            tapHandler();
          },
          child: Padding(
            padding: EdgeInsets.all(context.screenWidth * .025),
            child: Container(
              decoration: BoxDecoration(
                color: kBottomNavIconsColor,
                borderRadius: BorderRadius.circular(context.screenWidth * .045),
              ),
              padding: EdgeInsets.all(context.screenWidth * .015),
              width: context.screenWidth * .12,
              alignment: Alignment.center,
              child: Icon(Icons.notifications_outlined, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
