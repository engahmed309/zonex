// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_user_data_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RefreshUserDataEntityAdapter extends TypeAdapter<RefreshUserDataEntity> {
  @override
  final int typeId = 1;

  @override
  RefreshUserDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RefreshUserDataEntity(
      id: fields[0] as int,
      userName: fields[1] as String,
      phoneNumber: fields[2] as String,
      email: fields[3] as String,
      kiloShare: fields[4] as int,
      userImage: fields[5] as String,
      gender: fields[6] as String,
      groupsRequestsCount: fields[7] as int,
      notificationCount: fields[8] as int,
      tripRequestsCounts: fields[9] as int,
      invitationsCount: fields[10] as int,
      allMembersCounts: fields[11] as int,
      kiloShareCount: fields[12] as int,
      tripsCount: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RefreshUserDataEntity obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.kiloShare)
      ..writeByte(5)
      ..write(obj.userImage)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.groupsRequestsCount)
      ..writeByte(8)
      ..write(obj.notificationCount)
      ..writeByte(9)
      ..write(obj.tripRequestsCounts)
      ..writeByte(10)
      ..write(obj.invitationsCount)
      ..writeByte(11)
      ..write(obj.allMembersCounts)
      ..writeByte(12)
      ..write(obj.kiloShareCount)
      ..writeByte(13)
      ..write(obj.tripsCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefreshUserDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
