import 'package:flutter/material.dart';

class HomeGridViewModel {
  final String gridTitle;
  final String imagePath;
  final bool isActive;
  final Widget optionalLeading;
  final Function gridTapHandler;

  HomeGridViewModel({
    required this.optionalLeading,
    required this.gridTapHandler,
    required this.gridTitle,
    required this.imagePath,
    required this.isActive,
  });
}
