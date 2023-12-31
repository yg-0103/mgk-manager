import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mgk_manager/features/authentication/authentication_repo.dart';

class SignInViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr build() {
    _authRepo = ref.read(authRepo);
  }

  FutureOr<void> signIn() async {
    state = const AsyncValue.loading();
    final form = ref.read(signInForm);

    state = await AsyncValue.guard(
      () async => await _authRepo.signIn(form['email'], form['password']),
    );
  }
}

final signInForm = StateProvider((ref) => {});

final signInProvider = AsyncNotifierProvider<SignInViewModel, void>(
  () => SignInViewModel(),
);
