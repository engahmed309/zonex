class CountAll {
  int? requestGroups;
  int? notification;
  int? requestTrip;
  int? invitations;
  int? allMember;
  int? kiloShar;
  int? trips;

  CountAll({
    this.requestGroups,
    this.notification,
    this.requestTrip,
    this.invitations,
    this.allMember,
    this.kiloShar,
    this.trips,
  });

  factory CountAll.fromJson(Map<String, dynamic> json) => CountAll(
        requestGroups: json['request_groups'] as int?,
        notification: json['notification'] as int?,
        requestTrip: json['request_trip'] as int?,
        invitations: json['invitations'] as int?,
        allMember: json['AllMember'] as int?,
        kiloShar: json['KiloShar'] as int?,
        trips: json['trips'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'request_groups': requestGroups,
        'notification': notification,
        'request_trip': requestTrip,
        'invitations': invitations,
        'AllMember': allMember,
        'KiloShar': kiloShar,
        'trips': trips,
      };
}
