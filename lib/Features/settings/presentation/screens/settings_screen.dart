import 'package:flutter/material.dart';
import 'package:zonex/Features/settings/presentation/widget/settings_screen_body.dart';
import 'package:zonex/core/utils/helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.screenWidth * .04),
      child: const SettingsScreenBody(),
    );
  }
}
