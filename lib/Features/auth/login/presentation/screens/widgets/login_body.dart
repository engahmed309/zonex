import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';
import 'package:zonex/Features/auth/login/presentation/manager/login_cubit.dart';
import 'package:zonex/Features/auth/login/presentation/screens/widgets/animated_logo.dart';
import 'package:zonex/core/utils/commons.dart';
import 'package:zonex/core/utils/helper.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/functions/validation_mixin.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_login_text_field.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> with ValidationMixin {
  final phoneController = TextEditingController();
  final passWordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var userDataBox = Hive.box<LoginEntity>(kUserDataBox);
    // var newTokenBox = Hive.box<String>(kNewTokenBox);
    // final refreshUserDataBox = Hive.box<RefreshUserDataEntity>(
    //   kRefreshUserDataBox,
    // );
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) async {
            if (state is LoginSuccessful) {
              Commons.showToast(
                context,
                message: 'Success',
                color: Colors.green,
              );
              //Save user data in hive
              await userDataBox.clear();
              await userDataBox.add(state.user);
              Navigator.pushReplacementNamed(context, kBottomNavRoute);
              // var user = userDataBox.getAt(0);
              // print(user!.createdAt);
            }
            if (state is LoginFailed) {
              Commons.showToast(
                context,
                message: state.message,
                color: Colors.red,
              );
            }
          },
        ),
      ],

      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * .04,
              vertical: context.screenHeight * .03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedLogo(),
                SizedBox(height: context.screenHeight * .01),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomLoginTextField(
                        rowString: context.locale.translate("email"),
                        // rowIconPath: AssetsData.phoneIcon,
                        controller: phoneController,
                        hintInTextField: context.locale.translate("email")!,
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      SizedBox(height: context.screenHeight * .01),
                      CustomLoginTextField(
                        rowString: context.locale.translate("password"),
                        // rowIconPath: AssetsData.lockIcon,
                        controller: passWordController,
                        hintInTextField: "***********",
                        obscureText: true,
                        textInputType: TextInputType.text,
                        validator: validatePassWord,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * .03),
                Center(
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const CircularProgressIndicator(
                          color: kPrimaryColor,
                        );
                      } else {
                        return CustomButton(
                          onTapAvailable: true,
                          buttonText: context.locale.translate('login')!,
                          buttonTapHandler: () async {
                            // If keyboard is open, close it
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).login(
                                phoneController.text,
                                passWordController.text,
                              );
                            }
                            // Save user data to LoginEntity box
                          },
                          screenWidth: context.screenWidth,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: context.screenHeight * .03),
                InkWell(
                  onTap: () {
                    //  Navigator.pushNamed(context, kForgotPasswordScreenRoute);
                  },
                  child: Text(
                    context.locale.translate('did_you_forget_password')!,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: context.screenHeight * .08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.locale.translate('have_account')!,
                      style: TextStyle(
                        fontSize: context.screenWidth * .04,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    InkWell(
                      onTap: () async {
                        //   Navigator.pushNamed(context, kSignUpScreenRoute);
                      },
                      child: SizedBox(
                        width: context.screenWidth * .4,
                        child: Text(
                          context.locale.translate('create_account')!,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: context.screenWidth * .04,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
