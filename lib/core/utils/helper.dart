import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Features/home/presentation/manager/cubit/bottom_nav_cubit.dart';
import '../locale/app_localizations.dart';

extension MediaQueryHelper on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  Size get screenSize => MediaQuery.of(this).size;
  AppLocalizations get locale => AppLocalizations.of(this)!;
}

extension NavigatorHelper on BuildContext {
  void push(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }
}

extension BackHelper on BuildContext {
  void pushBack() {
    BlocProvider.of<BottomNavCubit>(this).updateBottomNavIndex(0);
  }
}

extension SnackbarHelper on BuildContext {
  void showSnackBar(
    String message, {
    Color? backGroundColor,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 2),
        backgroundColor: backGroundColor,
        content: Text(message),
      ),
    );
  }
}
