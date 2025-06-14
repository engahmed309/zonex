import 'package:flutter/material.dart';
import 'package:zonex/Features/auth/login/presentation/screens/login_screen.dart';
import 'package:zonex/Features/auth/register/presentation/screens/register_screen.dart';
import 'package:zonex/Features/home/data/models/products_model/products_model.dart';
import 'package:zonex/Features/home/presentation/screens/all_products_screen.dart';
import 'package:zonex/Features/home/presentation/screens/home_screen.dart';
import 'package:zonex/Features/home/presentation/screens/product_details_screen.dart';
import 'package:zonex/Features/language/presentation/screens/language_screen.dart';
import 'package:zonex/Features/orders/presentation/screens/order_details_screen.dart';
import 'package:zonex/Features/profile/presentation/screens/profile_screen.dart';

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
      case kProductDetailsScreenRoute:
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: args as ProductsModel),
        );
      case kAllProductsScreenRoute:
        return MaterialPageRoute(
          builder: (_) =>
              AllProductsScreen(allProducts: args as List<ProductsModel>),
        );
      case kRegisterScreenRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case kProfileScreenRoute:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case kOrderDetailsScreenRoute:
        return MaterialPageRoute(
          builder: (_) =>
              OrderDetailsScreen(order: args as Map<String, dynamic>),
        );
      default:
        return null;
    }
  }
}
