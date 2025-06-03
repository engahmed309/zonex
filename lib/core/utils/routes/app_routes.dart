import 'package:flutter/material.dart';
import 'package:zonex/Features/auth/login/presentation/screens/login_screen.dart';
import 'package:zonex/Features/home/presentation/screens/home_screen.dart';
import 'package:zonex/Features/language/presentation/screens/language_screen.dart';

import '../../../Features/Splash/presentation/views/splash_screen.dart';
import '../../../Features/home/presentation/widgets/bottom_nav_widget.dart';
import '../constants.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case kLanguageScreenRoute:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case kHomeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case kLoginScreenRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case kBottomNavRoute:
        return MaterialPageRoute(builder: (_) => const BottomNavWidget());
      // case kBookDetailsScreen:
      //   return MaterialPageRoute(builder: (_) => const BookDetailsView());

      default:
        return null;
    }
  }
}
