import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zonex/Features/auth/register/data/data_source/register_remote_data_source.dart';
import 'package:zonex/core/utils/commons.dart';
import 'package:zonex/core/utils/constants.dart';
import 'package:zonex/core/utils/functions/validation_mixin.dart';
import 'package:zonex/core/utils/helper.dart';
import 'package:zonex/core/widgets/custom_button.dart';
import 'package:zonex/core/widgets/custom_login_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? _pickedImage;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * .04,
              vertical: context.screenHeight * .03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: context.screenWidth * 0.15,
                      backgroundImage: _pickedImage != null
                          ? FileImage(_pickedImage!)
                          : null,
                      child: _pickedImage == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: context.screenWidth * 0.1,
                              color: Colors.white70,
                            )
                          : null,
                    ),
                  ),
                ),

                SizedBox(height: context.screenHeight * .01),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomLoginTextField(
                              rowString: context.locale.translate("first_name"),
                              controller: firstNameController,
                              hintInTextField: context.locale.translate(
                                "first_name",
                              )!,
                              obscureText: false,
                              textInputType: TextInputType.name,
                              validator: validateNameText,
                            ),
                          ),
                          SizedBox(width: context.screenWidth * .02),
                          Expanded(
                            child: CustomLoginTextField(
                              rowString: context.locale.translate("last_name"),
                              controller: lastNameController,
                              hintInTextField: context.locale.translate(
                                "last_name",
                              )!,
                              obscureText: false,
                              textInputType: TextInputType.name,
                              validator: validateNameText,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.screenHeight * .01),
                      CustomLoginTextField(
                        rowString: context.locale.translate("email"),
                        controller: emailController,
                        hintInTextField: context.locale.translate("email")!,
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      SizedBox(height: context.screenHeight * .01),
                      CustomLoginTextField(
                        rowString: context.locale.translate("phone"),
                        controller: phoneController,
                        hintInTextField: context.locale.translate("phone")!,
                        obscureText: false,
                        textInputType: TextInputType.phone,
                        validator: validatePhoneNumber,
                      ),
                      SizedBox(height: context.screenHeight * .01),
                      CustomLoginTextField(
                        rowString: context.locale.translate("address"),
                        controller: addressController,
                        hintInTextField: context.locale.translate("address")!,
                        obscureText: false,
                        textInputType: TextInputType.streetAddress,
                        validator: validateInputText,
                      ),
                      SizedBox(height: context.screenHeight * .01),
                      CustomLoginTextField(
                        rowString: context.locale.translate("password"),
                        controller: passwordController,
                        hintInTextField: "***********",
                        obscureText: true,
                        textInputType: TextInputType.text,
                        validator: validatePassWord,
                      ),
                      SizedBox(height: context.screenHeight * .01),
                      CustomLoginTextField(
                        rowString: context.locale.translate("confirm_password"),
                        controller: confirmPasswordController,
                        hintInTextField: "***********",
                        obscureText: true,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.locale.translate("field_required");
                          }
                          if (value != passwordController.text) {
                            return context.locale.translate(
                              "passwords_do_not_match",
                            );
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * .03),
                Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          onTapAvailable: true,
                          buttonText: context.locale.translate(
                            'create_account',
                          )!,
                          screenWidth: context.screenWidth,
                          buttonTapHandler: () async {
                            FocusManager.instance.primaryFocus?.unfocus();

                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                await AddUserRemoteDataSourceImpl().register(
                                  address: addressController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                  email: emailController.text,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                                await Hive.box(
                                  kUserImageBox,
                                ).put('image', _pickedImage!.path);

                                Commons.showToast(
                                  context,
                                  message: context.locale.translate(
                                    "account_created_successfully",
                                  )!,
                                  color: Colors.green,
                                );

                                Navigator.pushReplacementNamed(
                                  context,
                                  kLoginScreenRoute,
                                );
                              } catch (e) {
                                Commons.showToast(
                                  context,
                                  message: e.toString(),
                                  color: Colors.red,
                                );
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            }
                          },
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
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: context.screenWidth * .4,
                        child: Text(
                          context.locale.translate('login')!,
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
