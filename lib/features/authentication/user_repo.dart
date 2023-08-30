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

  Future<Map<String, dynamic>?> updateLog(UserLogsModel userLog) async {
    final userLogs = await findLogs(userLog.userId);
    final userLogModel = UserLogsModel.fromJson(userLogs!);

    await _db.collection('usersLog').doc(userLog.userId).update({
      "date": [...userLogModel.date, userLog.date[0]]
    });
    return null;
  }
}

final userRepo = Provider((ref) => UserRepository());
