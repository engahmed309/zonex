import 'package:flutter/material.dart';

class CustomSettingItem extends StatelessWidget {
  const CustomSettingItem({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailingIcon,
    required this.leadingIconColor,
    required this.onTap,
  });
  final IconData leadingIcon;
  final String title;
  final IconData trailingIcon;
  final Color leadingIconColor;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(leadingIcon, color: leadingIconColor),
        title: Text(title),
        trailing: Icon(trailingIcon),
        onTap: () {
          onTap!();
        },
        //Rounded and elevated
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.grey[200],
      ),
    );
  }
}
