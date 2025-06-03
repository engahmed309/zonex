// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';

import '../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginRequest;

  LoginCubit(this.loginRequest) : super(LoginInitial());

  Future<void> login(String phone, String password) async {
    emit(const LoginLoading());
    final result = await loginRequest.call(phone, password);

    emit(result.fold(LoginFailed.new, LoginSuccessful.new));
  }
}
