class User {
  final String phone;

  User({required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(phone: json['phone'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'phone': phone};
  }
}
