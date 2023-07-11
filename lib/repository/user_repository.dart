import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgk_manager/repository/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const IS_AUTHENTICATED_KEY = "IS_AUTHENTICATED_KEY";

final sharedPrefProvider = Provider((ref) async {
  return await SharedPreferences.getInstance();
});

final setAuthStateProvider = StateProvider<UserModel?>((ref) => null);

final setIsAuthenticatedProvider =
    StateProvider.family<void, bool>((ref, isAuth) async {
  final prefs = await ref.watch(sharedPrefProvider);
  ref.watch(setAuthStateProvider);

  prefs.setBool(IS_AUTHENTICATED_KEY, isAuth);
});

final getIsAuthenticationProvider = FutureProvider<bool>((ref) async {
  final prefs = await ref.watch(sharedPrefProvider);
  ref.watch(setAuthStateProvider);

  return prefs.getBool(IS_AUTHENTICATED_KEY) ?? false;
});
