class User {
  int? userId;
  String? password;
  String? phoneNumber;
  String? name;
  String? username;
  String? email;
  dynamic profilePicture;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.userId,
    this.password,
    this.phoneNumber,
    this.name,
    this.username,
    this.email,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: int.tryParse(json["user_id"].toString()) ?? 0,
      password: json["password"],
      phoneNumber: json["phone_number"],
      name: json["name"] ?? 'No name', // Default to 'No name' if null
      username:
          json["username"] ?? 'No username', // Default to 'No username' if null
      email: json["email"],
      profilePicture: json["profile_picture"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
    );
  }
}
