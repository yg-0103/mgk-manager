class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final int color;

  const UserModel(
      {this.id,
      required this.name,
      required this.color,
      required this.email,
      required this.password});

  toJson() {
    return {"name": name, "color": color, "email": email, "password": password};
  }
}
