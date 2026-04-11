class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
  });

  // ✅ IMPORTANT
  User copyWith({String? name, String? phone, String? address, String? image}) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      image: image ?? this.image,
    );
  }
}
