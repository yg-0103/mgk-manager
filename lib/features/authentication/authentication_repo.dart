import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;

  FutureOr<UserCredential> signIn(String email, String password) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> authStateChange() => _firebaseAuth.authStateChanges();
}

final authRepo = Provider(
  (ref) => AuthenticationRepository(),
);

final authState = StreamProvider((ref) {
  var repo = ref.read(authRepo);

  return repo.authStateChange();
});
