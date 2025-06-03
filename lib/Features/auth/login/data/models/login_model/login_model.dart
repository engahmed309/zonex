import 'package:zonex/Features/auth/login/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  final bool? state;
  final String? message;

  LoginModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.address,
    required super.email,
    required super.createdAt,
    required super.token,
    this.state,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      state: json['state'] as bool?,
      message: json['message'] as String?,
      id: json['data']['id'],
      firstName: json['data']['first_name'],
      lastName: json['data']['last_name'],
      phone: json['data']['phone'],
      address: json['data']['address'],
      email: json['data']['email'],
      createdAt: json['data']['created_at'],
      token: json['data']['token'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'message': message,
      'data': {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'address': address,
        'email': email,
        'created_at': createdAt,
        'token': token,
      },
    };
  }
}
