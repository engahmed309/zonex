import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';
import 'package:zonex/core/utils/commons.dart';
import 'package:zonex/core/utils/constants.dart';
import 'package:zonex/core/utils/functions/validation_mixin.dart';
import 'package:zonex/core/utils/helper.dart';
import 'package:zonex/core/widgets/custom_button.dart';
import 'package:zonex/core/widgets/custom_login_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with ValidationMixin {
  late Box<LoginEntity> userBox;
  late Box imageBox;

  LoginEntity? user;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  File? _pickedImage;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    userBox = Hive.box<LoginEntity>(kUserDataBox);
    imageBox = Hive.box(kUserImageBox);

    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
      if (user != null) {
        firstNameController.text = user!.firstName;
        lastNameController.text = user!.lastName;
        phoneController.text = user!.phone;
        addressController.text = user!.address;
        emailController.text = user!.email;
      }
    }

    final imagePath = imageBox.get('image');
    if (imagePath != null && imagePath.isNotEmpty) {
      _pickedImage = File(imagePath);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!formKey.currentState!.validate()) return;

    if (user == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final updatedUser = LoginEntity(
        id: user!.id,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        email: emailController.text.trim(),
        createdAt: user!.createdAt,
        token: user!.token,
      );

      await userBox.putAt(0, updatedUser);

      if (_pickedImage != null) {
        await imageBox.put('image', _pickedImage!.path);
      }

      Commons.showToast(
        context,
        message: 'Data updated successfully',
        color: Colors.green,
      );
    } catch (e) {
      Commons.showToast(
        context,
        message: 'An error occurred while saving data',
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

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: user == null
          ? const Center(child: Text('No user data available'))
          : ListView(
              padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth * 0.04,
                vertical: context.screenHeight * 0.03,
              ),
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: context.screenWidth * 0.15,
                        backgroundImage: _pickedImage != null
                            ? FileImage(_pickedImage!)
                            : null,
                        backgroundColor: Colors.grey.shade300,
                        child: _pickedImage == null
                            ? Icon(
                                Icons.person,
                                size: context.screenWidth * 0.15,
                                color: Colors.white70,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: context.screenWidth * 0.05,
                            backgroundColor: kPrimaryColor,
                            child: Icon(
                              Icons.edit,
                              size: context.screenWidth * 0.05,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.03),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomLoginTextField(
                              rowString: 'First Name',
                              controller: firstNameController,
                              hintInTextField: 'First Name',
                              obscureText: false,
                              textInputType: TextInputType.name,
                              validator: validateNameText,
                            ),
                          ),
                          SizedBox(width: context.screenWidth * 0.02),
                          Expanded(
                            child: CustomLoginTextField(
                              rowString: 'Last Name',
                              controller: lastNameController,
                              hintInTextField: 'Last Name',
                              obscureText: false,
                              textInputType: TextInputType.name,
                              validator: validateNameText,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.screenHeight * 0.01),
                      CustomLoginTextField(
                        rowString: 'Email',
                        controller: emailController,
                        hintInTextField: 'Email',
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      SizedBox(height: context.screenHeight * 0.01),
                      CustomLoginTextField(
                        rowString: 'Phone',
                        controller: phoneController,
                        hintInTextField: 'Phone',
                        obscureText: false,
                        textInputType: TextInputType.phone,
                        validator: validatePhoneNumber,
                      ),
                      SizedBox(height: context.screenHeight * 0.01),
                      CustomLoginTextField(
                        rowString: 'Address',
                        controller: addressController,
                        hintInTextField: 'Address',
                        obscureText: false,
                        textInputType: TextInputType.streetAddress,
                        validator: validateInputText,
                      ),
                      SizedBox(height: context.screenHeight * 0.03),
                      Center(
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                onTapAvailable: true,
                                buttonText: 'Save Changes',
                                screenWidth: context.screenWidth,
                                buttonTapHandler: _saveProfile,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
