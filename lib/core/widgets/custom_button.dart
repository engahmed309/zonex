import 'package:flutter/material.dart';
import 'package:zonex/core/utils/helper.dart';

import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.iconColor,
    this.borderRadius,
    this.buttonBackGroundColor,
    this.icon,
    this.height,
    required this.screenWidth,
    required this.buttonTapHandler,
    required this.buttonText,
    this.withIcon = false,
    this.haveBorder = false,
    this.textColor,
    this.borderColor,
    this.onTapAvailable = true,
  });
  final double screenWidth;
  final Function buttonTapHandler;
  final String buttonText;
  final Color? buttonBackGroundColor;
  final Color? borderColor;
  final Color? iconColor;

  final Color? textColor;
  final double? borderRadius;
  final double? height;
  final bool haveBorder;
  final bool onTapAvailable;
  final bool withIcon;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        buttonTapHandler();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: buttonBackGroundColor ?? kPrimaryColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        height: height ?? context.screenHeight * .07,
        width: screenWidth == 0.0 ? 150.0 : screenWidth,
        child: withIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(icon!, color: iconColor),
                  SizedBox(
                    width: context.locale.isEnLocale
                        ? context.screenWidth * .2
                        : context.screenWidth * .28,
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.screenWidth * .045,
                        color: textColor ?? kWhiteColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : Text(
                buttonText,
                style: TextStyle(
                  fontSize: context.screenWidth * .045,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? kWhiteColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}
