import 'package:hive/hive.dart';

part 'login_entity.g.dart';

@HiveType(typeId: 1)
class LoginEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String createdAt;

  @HiveField(7)
  final String token;

  LoginEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.email,
    required this.createdAt,
    required this.token,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      address: json['address'],
      email: json['email'],
      createdAt: json['created_at'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'phone': phone,
    'address': address,
    'email': email,
    'created_at': createdAt,
    'token': token,
  };
}
