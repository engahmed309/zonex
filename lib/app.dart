import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zonex/Features/home/presentation/manager/cubit/bottom_nav_cubit.dart';
import 'package:zonex/Features/splash/presentation/manger/locale_cubit/locale_cubit.dart';
import 'package:zonex/core/utils/constants.dart';

import 'core/locale/app_localizations_setup.dart';
import 'core/utils/functions/setup_service_locator.dart';
import 'core/utils/routes/app_routes.dart';

class ZoneX extends StatelessWidget {
  const ZoneX({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LocaleCubit>()..getSavedLang()),
        BlocProvider(create: (_) => getIt<BottomNavCubit>()),
        // BlocProvider(
        //   create: (_) => getIt<RefreshUserDataCubit>(),
        // ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        builder: (_, localeState) {
          return MaterialApp(
            locale: localeState.locale,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
              // primarySwatch: Colors.blue,
            ),
            themeMode:
                ThemeMode.system, // Can be ThemeMode.light or ThemeMode.dark
            theme: ThemeData(
              brightness: Brightness.light,

              primaryColor: kPrimaryColor,
              appBarTheme: const AppBarTheme(
                foregroundColor: Colors.white,
                scrolledUnderElevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Montserrat-Regular.ttf',
                  fontWeight: FontWeight.bold,
                ),
              ),
              fontFamily: "Montserrat-Regular.ttf",
              primarySwatch: Colors.teal,
            ),

            // ThemeData.dark().copyWith(
            //   scaffoldBackgroundColor: kPrimaryColor,
            //   textTheme:
            //       GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
            // ),
          );
        },
      ),
    );
  }
}
