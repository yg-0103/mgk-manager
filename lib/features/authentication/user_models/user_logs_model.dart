class UserLogsModel {
  final List<dynamic> date;
  final String userColor;
  final String name;
  final String userId;

  UserLogsModel({
    required this.userColor,
    required this.name,
    required this.userId,
    required this.date,
  });

  UserLogsModel.empty()
      : userId = '',
        userColor = '',
        name = '',
        date = [DateTime.now()];

  UserLogsModel.fromJson(Map<dynamic, dynamic> json)
      : userId = json['userId'],
        userColor = json['userColor'],
        name = json['name'],
        date = json['date'];
}
