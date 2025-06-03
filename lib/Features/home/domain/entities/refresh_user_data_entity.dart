import 'package:hive/hive.dart';

part 'refresh_user_data_entity.g.dart';

@HiveType(typeId: 1)
class RefreshUserDataEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final String phoneNumber;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final int kiloShare;
  @HiveField(5)
  final String userImage;
  @HiveField(6)
  final String gender;
  @HiveField(7)
  final int groupsRequestsCount;
  @HiveField(8)
  final int notificationCount;
  @HiveField(9)
  final int tripRequestsCounts;
  @HiveField(10)
  final int invitationsCount;
  @HiveField(11)
  final int allMembersCounts;
  @HiveField(12)
  final int kiloShareCount;
  @HiveField(13)
  final int tripsCount;

  RefreshUserDataEntity({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.kiloShare,
    required this.userImage,
    required this.gender,
    required this.groupsRequestsCount,
    required this.notificationCount,
    required this.tripRequestsCounts,
    required this.invitationsCount,
    required this.allMembersCounts,
    required this.kiloShareCount,
    required this.tripsCount,
  });
}
