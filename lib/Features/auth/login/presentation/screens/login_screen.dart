import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zonex/Features/auth/login/presentation/manager/login_cubit.dart';
import 'package:zonex/core/utils/functions/setup_service_locator.dart';

import 'widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: FadeInDown(
        child: BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginBody(),
        ),
      ),
    );
  }
}
