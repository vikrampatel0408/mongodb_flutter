class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print("Parsing user data from JSON:");
    print(json);

    return UserModel(
      id: json['_id'], // Use '_id' instead of 'id'
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}
