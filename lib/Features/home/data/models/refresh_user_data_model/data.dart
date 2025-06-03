import 'count_all.dart';

class Data {
  int? id;
  String? userName;
  String? gender;
  String? userImage;
  String? phone;
  String? email;
  int? kiloShare;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? tokenNoti;
  CountAll? countAll;

  Data({
    this.id,
    this.userName,
    this.gender,
    this.userImage,
    this.phone,
    this.email,
    this.kiloShare,
    this.createdAt,
    this.updatedAt,
    this.tokenNoti,
    this.countAll,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        userName: json['user_name'] as String?,
        gender: json['gender'] as String?,
        userImage: json['user_image'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        kiloShare: json['kilo_share'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        tokenNoti: json['tokenNoti'] as String?,
        countAll: json['count_all'] == null
            ? null
            : CountAll.fromJson(json['count_all'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': userName,
        'gender': gender,
        'user_image': userImage,
        'phone': phone,
        'email': email,
        'kilo_share': kiloShare,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'tokenNoti': tokenNoti,
        'count_all': countAll?.toJson(),
      };
}
