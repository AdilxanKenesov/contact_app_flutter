class Contact {
  final String id;
  final String name;
  final String phone;

  Contact({required this.id, required this.name, required this.phone});

  factory Contact.fromJson(String id, Map<String, dynamic> json) {
    return Contact(
      id: id,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  Contact copyWith({String? name, String? phone}) {
    return Contact(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
