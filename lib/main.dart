import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';
import 'package:zonex/app.dart';
import 'package:zonex/core/utils/constants.dart';
import 'package:zonex/core/utils/simple_bloc_observer.dart';

import 'core/utils/functions/setup_service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  await di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(LoginEntityAdapter());

  await Hive.openBox<LoginEntity>(kUserDataBox);
  runApp(const ZoneX());
}
