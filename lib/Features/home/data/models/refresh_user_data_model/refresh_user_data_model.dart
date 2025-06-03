import '../../../domain/entities/refresh_user_data_entity.dart';
import 'data.dart';

class RefreshUserDataModel extends RefreshUserDataEntity {
  Data? data;
  String? message;
  int? status;

  RefreshUserDataModel({this.data, this.message, this.status})
      : super(
          id: data!.id!,
          userName: data.userName!,
          phoneNumber: data.phone!,
          email: data.email!,
          kiloShare: data.kiloShare!,
          userImage: data.userImage!,
          gender: data.gender!,
          groupsRequestsCount: data.countAll!.requestGroups!,
          notificationCount: data.countAll!.notification!,
          tripRequestsCounts: data.countAll!.requestTrip!,
          invitationsCount: data.countAll!.invitations!,
          allMembersCounts: data.countAll!.allMember!,
          kiloShareCount: data.countAll!.kiloShar!,
          tripsCount: data.countAll!.trips!,
        );

  factory RefreshUserDataModel.fromJson(Map<String, dynamic> json) {
    return RefreshUserDataModel(
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
