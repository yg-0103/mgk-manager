import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mgk_manager/features/authentication/authentication_repo.dart';
import 'package:mgk_manager/features/authentication/user_models/user_logs_model.dart';
import 'package:mgk_manager/features/authentication/user_repo.dart';
import 'package:mgk_manager/features/authentication/view_models/user_view_model.dart';
import 'package:mgk_manager/features/home/widgets/table_event_calendar.dart';

final userLogsProvider =
    StateNotifierProvider<UserLogsNotifier, Map<String, List<DateTime>>>((ref) {
  return UserLogsNotifier();
});

class UserLogsNotifier extends StateNotifier<Map<String, List<DateTime>>> {
  UserLogsNotifier()
      : super({
          "김연구": [
            DateTime(2023, 6, 1),
            DateTime(2023, 6, 10),
            DateTime(2023, 6, 20)
          ],
          "한지선": [
            DateTime(2023, 6, 1),
            DateTime(2023, 6, 4),
            DateTime(2023, 6, 13),
            DateTime(2023, 6, 22)
          ],
          "송준호": [
            DateTime(2023, 6, 1),
            DateTime(2023, 6, 6),
            DateTime(2023, 6, 16),
            DateTime(2023, 6, 22)
          ],
          "권은비": [
            DateTime(2023, 6, 1),
            DateTime(2023, 6, 8),
            DateTime(2023, 6, 12),
            DateTime(2023, 6, 28)
          ]
        });

  void addUserLog({
    required String name,
    required String userId,
    required String userColor,
    required DateTime date,
    required WidgetRef ref,
  }) async {
    state = {
      ...state,
      name: [...(state[name] ?? []), date]
    };

    await ref.read(userRepo).updateLog(UserLogsModel(
        userColor: userColor, name: name, userId: userId, date: [date]));
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLogs = ref.watch(userLogsProvider);
    return ref.watch(usersProvider).when(
        error: (error, stackTrace) => Text('$error'),
        loading: () => const CircularProgressIndicator.adaptive(),
        data: (data) => Scaffold(
              appBar: AppBar(
                title: Text(data.userColor),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.logout_sharp),
                    tooltip: 'Logout!',
                    onPressed: () => {ref.read(authRepo).signOut()},
                  ),
                ],
              ),
              body: TableEventsCalender(
                userLogs: userLogs,
              ),
              floatingActionButton: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  fixedSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  ref.read(userLogsProvider.notifier).addUserLog(
                        name: data.name,
                        userId: data.userId,
                        userColor: data.userColor,
                        date: DateTime.now(),
                        ref: ref,
                      );
                },
                child: const Text('출석'),
              ),
            ));
  }
}
