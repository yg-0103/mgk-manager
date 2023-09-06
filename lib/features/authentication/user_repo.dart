import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mgk_manager/features/authentication/user_models/user_logs_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> findProfile(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    return doc.data();
  }

  Future<Map<String, dynamic>?> findLogs(String userId) async {
    final doc = await _db.collection('usersLog').doc(userId).get();
    return doc.data();
  }

  Future<Map<String, dynamic>?> initializeUserLogs(
      UserLogsModel userLogs) async {
    await _db.collection('usersLog').doc(userLogs.userId).set({
      'date': [userLogs.date[0]],
      'userColor': userLogs.userColor,
      'name': userLogs.name,
      'userId': userLogs.userId
    });
    return null;
  }

  Future<Map<String, dynamic>?> updateLog(UserLogsModel userLog) async {
    var userlog = await getUsersLog();
    final userLogs = await findLogs(userLog.userId);

    if (userLogs == null) {
      await initializeUserLogs(userLog);
      return null;
    }

    final userLogModel = UserLogsModel.fromJson(userLogs);

    await _db.collection('usersLog').doc(userLog.userId).update({
      "date": [...userLogModel.date, userLog.date[0]]
    });

    return null;
  }

  Future<Map<String, dynamic>> getUsersLog() async {
    var usersLog = await _db.collection('usersLog').get();
    var docs = usersLog.docs.map((doc) => UserLogsModel.fromJson(doc.data()));

    Map<String, dynamic> userLogs = {};

    for (var doc in docs) {
      // 각 요소에서 'name' 키와 'age' 키의 값을 추출하여 새로운 맵에 추가합니다.
      String name = doc.name;
      List<dynamic> date = doc.date;
      userLogs[name] = date;
    }

    return userLogs;
  }
}

final userRepo = Provider((ref) => UserRepository());
