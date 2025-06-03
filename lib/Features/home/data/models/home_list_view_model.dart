import 'dart:ui';

class HomeListViewModel {
  final String containerName;
  String? containerText;
  final String measuringUnit;
  final String imagePath;
  final Color containerBackGroundColors;
  final Color iconBackGroundColors;
  final Function tapHandler;
  final bool hasRefreshIcon;
  Function? refreshTapHandler;

  HomeListViewModel(
      {required this.measuringUnit,
      this.refreshTapHandler,
      required this.hasRefreshIcon,
      required this.containerName,
      required this.tapHandler,
      this.containerText,
      required this.imagePath,
      required this.iconBackGroundColors,
      required this.containerBackGroundColors});
}
