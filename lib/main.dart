import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  await Hive.openBox(kUserImageBox);
  await Supabase.initialize(
    url: 'https://efyxlrnkywdymjwjlerw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVmeXhscm5reXdkeW1qd2psZXJ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg5OTAxNDgsImV4cCI6MjA2NDU2NjE0OH0.di56bLSmeDsu_ApUPK7FIea2gbu-wKtroQ1rb2NFlk4',
  );

  runApp(const ZoneX());
}
