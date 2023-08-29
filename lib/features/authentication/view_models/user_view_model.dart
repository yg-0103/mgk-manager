import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mgk_manager/features/authentication/authentication_repo.dart';
import 'package:mgk_manager/features/authentication/user_models/user_profile_model.dart';
import 'package:mgk_manager/features/authentication/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final AuthenticationRepository _authRepo;
  late final UserRepository _userRepo;

  @override
  FutureOr<UserProfileModel> build() async {
    _authRepo = ref.read(authRepo);
    _userRepo = ref.read(userRepo);

    if (_authRepo.isLoggedIn) {
      final userProfile = await _userRepo.findProfile(_authRepo.user!.uid);

      if (userProfile != null) {
        return UserProfileModel.fromJson(userProfile);
      }
    }

    return UserProfileModel.empty();
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
