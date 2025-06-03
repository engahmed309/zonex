import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zonex/core/utils/helper.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../splash/presentation/manger/locale_cubit/locale_cubit.dart';
// ignore: depend_on_referenced_packages

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    locale = AppLocalizations.of(context)!;

    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeInDown(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * .02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<LocaleCubit>(context).toArabic();
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            decoration: !locale.isEnLocale
                                ? BoxDecoration(
                                    border: Border.all(
                                      color: kPrimaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  )
                                : null,
                            padding: EdgeInsets.symmetric(
                              vertical: context.screenHeight * .02,
                            ),
                            width: screenSize.width * .4,
                            height: screenSize.height * .22,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  AssetsData.arabicLangImage,
                                  width: screenSize.width * .2,
                                  height: screenSize.height * .1,
                                ),
                                Text(
                                  "عربي",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.screenWidth * .055,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<LocaleCubit>(context).toEnglish();
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            decoration: locale.isEnLocale
                                ? BoxDecoration(
                                    border: Border.all(
                                      color: kPrimaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  )
                                : null,
                            padding: EdgeInsets.symmetric(
                              vertical: context.screenHeight * .02,
                            ),
                            width: screenSize.width * .4,
                            height: screenSize.height * .22,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  AssetsData.englishLangImage,
                                  width: screenSize.width * .2,
                                  height: screenSize.height * .1,
                                ),
                                Text(
                                  "English",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.screenWidth * .055,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  buttonText: locale.translate("choose")!,
                  screenWidth: screenSize.width * .8,
                  buttonTapHandler: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    bool seen = (pref.getBool('lang_seen') ?? false);

                    if (seen) {
                      Navigator.pop(context);
                    } else {
                      await pref.setBool('lang_seen', true);
                      Navigator.pushReplacementNamed(
                        context,
                        kLoginScreenRoute,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
