import 'package:flutter/material.dart';

import '../../locale/app_localizations.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String? validateUserPhone(String? phoneNo) {
    if (phoneNo!.trim().isEmpty) {
      return AppLocalizations.of(
        context,
      )!.translate("Please_enter_phone_number");
    }

    // else {
    //   if (phoneNo.contains("+2")) {
    //     if (phoneNo.length != 10) {
    //       return S.of(context).Please_enter_valid_phone_number;
    //     }
    //   } else if (phoneNo.startsWith("5")) {
    //     if (phoneNo.length != 9) {
    //       return S.of(context).Please_enter_valid_phone_number;
    //     }
    //   }
    // }

    return null;
  }

  String? validateInputText(String? inputText) {
    if (inputText == null || inputText.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate("enter_valid_value");
    }
    return null;
  }

  String? validateNewPassword(String? passWord) {
    newPassWord = passWord;

    if (passWord == null || passWord.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate("password_validation");
    } else if (passWord.length < 8) {
      return AppLocalizations.of(
        context,
      )!.translate("Please_enter_length_password");
    }
    return null;
  }

  String? newPassWord;
  String? confirmNewPassWord;

  String? validateConfirmPassword(String? passWord) {
    confirmNewPassWord = passWord;

    if (passWord == null || passWord.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate("password_validation");
    } else if (passWord.length < 8) {
      return AppLocalizations.of(
        context,
      )!.translate("Please_enter_length_password");
    } else if (newPassWord != confirmNewPassWord) {
      return AppLocalizations.of(context)!.translate("not_identical_password");
    }
    return null;
  }

  String? validateCurrentPassword(String? passWord) {
    if (passWord == null || passWord.trim().isEmpty) {
      return AppLocalizations.of(
        context,
      )!.translate("current_password_validation");
    }
    return null;
  }

  String? validateNameText(String? inputText) {
    if (inputText == null || inputText.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate("enter_valid_name");
    }
    return null;
  }

  String? validateAddress(String? inputText) {
    if (inputText == null || inputText.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate("enter_valid_address");
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email!.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate("email_validation");
    } else if (!RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
    ).hasMatch(email)) {
      return AppLocalizations.of(context)!.translate("enter_valid_email");
    }
    return null;
  }

  String? validatePassWord(String? password) {
    if (password!.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate("password_validation");
    } else if (password.length < 6) {
      return AppLocalizations.of(
        context,
      )!.translate("Please_enter_length_password");
    }
    return null;
  }

  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber!.isEmpty) {
      return AppLocalizations.of(
        context,
      )!.translate("Please_enter_phone_number");
    } else if (phoneNumber.length != 11) {
      return AppLocalizations.of(context)!.translate("enter_valid_phone");
    }
    return null;
  }

  // String? validateConfirmPassWord(String? passWord) {
  //   if (passWord!.isEmpty) {
  //     return S.of(context).Please_enter_confirm_password;
  //   } else if (passWord.length < 8) {
  //     return S.of(context).Password_must_be_at_least_8_characters;
  //   }
  //   return null;
  // }
}
