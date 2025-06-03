import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zonex/Features/settings/presentation/screens/settings_screen.dart';

import '../../screens/home_screen.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  int bottomNavIndex = 0;
  bool drawerIsOpen = false;
  late String? messageId;
  List<Widget> bottomNavScreens = [
    //THREE BOTTOM NAV ITEMS
    HomeScreen(),
    HomeScreen(),
    SettingsScreen(),
    SettingsScreen(),
  ];

  Widget get selectedBottomNavScreen => bottomNavScreens[bottomNavIndex];

  ListQueue<int> navigationQueue = ListQueue();

  void updateBottomNavIndex(int value) {
    emit(BottomNavInitial());
    bottomNavIndex = value;
    emit(BottomNavIsChanging());
  }

  void changeDrawerState(bool value) {
    emit(BottomNavInitial());
    drawerIsOpen = value;
    emit(DrawerState());
  }

  void getMessageId(String value) {
    emit(BottomNavInitial());
    messageId = value;
    emit(BottomNavIsChanging());
  }
}
