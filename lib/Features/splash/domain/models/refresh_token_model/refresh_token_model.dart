import 'data.dart';

class RefreshTokenModel {
  Data? data;
  String? message;
  int? status;

  RefreshTokenModel({this.data, this.message, this.status});

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
    'message': message,
    'status': status,
  };
}
