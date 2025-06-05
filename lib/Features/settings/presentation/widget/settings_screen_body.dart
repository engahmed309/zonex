import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';
import 'package:zonex/Features/settings/presentation/widget/custom_setting_item.dart';
import 'package:zonex/core/utils/constants.dart';
import 'package:zonex/core/utils/helper.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    var userDataBox = Hive.box<LoginEntity>(kUserDataBox);
    return ListView(
      children: [
        CustomSettingItem(
          title: context.locale.translate("edit_profile")!,
          leadingIcon: Icons.person_rounded,
          trailingIcon: Icons.arrow_forward_ios,
          leadingIconColor: Colors.green,
          onTap: () {
            Navigator.pushNamed(context, kProfileScreenRoute);
          },
        ),
        CustomSettingItem(
          title: context.locale.translate("language")!,
          leadingIcon: Icons.language_rounded,
          trailingIcon: Icons.arrow_forward_ios,
          leadingIconColor: Colors.green,
          onTap: () {
            Navigator.pushNamed(context, kLanguageScreenRoute);
          },
        ),
        CustomSettingItem(
          title: context.locale.translate("log_out")!,
          leadingIcon: Icons.logout_rounded,
          trailingIcon: Icons.arrow_forward_ios,
          leadingIconColor: Colors.red,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                  content: Text(
                    context.locale.translate("alert_text")!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        context.locale.translate("no")!,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await userDataBox.clear();
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                          context,
                          kLoginScreenRoute,
                        );
                      },
                      child: Text(
                        context.locale.translate("yes")!,
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
