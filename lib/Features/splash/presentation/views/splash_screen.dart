import 'package:flutter/material.dart';
import 'package:zonex/core/utils/constants.dart';

import 'widgets/splash_screen_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kPrimaryColor, body: SplashScreenBody());
  }
}
