class UserProfileModel {
  final String email;
  final String userColor;
  final String name;
  final String userId;

  UserProfileModel({
    required this.userColor,
    required this.name,
    required this.userId,
    required this.email,
  });

  UserProfileModel.empty()
      : userId = '',
        userColor = '',
        name = '',
        email = '';

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        userColor = json['userColor'],
        name = json['name'],
        email = json['email'];
}
