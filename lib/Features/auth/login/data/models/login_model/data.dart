class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? email;
  String? createdAt;
  String? token;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.email,
    this.createdAt,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'] as int?,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    phone: json['phone'] as String?,
    address: json['address'] as String?,
    email: json['email'] as String?,
    createdAt: json['created_at'] as String?,
    token: json['token'] as String?,
  );

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
