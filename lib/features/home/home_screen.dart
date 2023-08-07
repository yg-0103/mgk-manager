import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mgk_manager/features/authentication/authentication_repo.dart';
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

  void addUserLog({required String name, required DateTime date}) {
    state = {
      ...state,
      name: [...(state[name] ?? []), date]
    };
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLogs = ref.watch(userLogsProvider);
    final user = ref.read(authRepo).user;
    return Scaffold(
      appBar: AppBar(title: const Text('MGK'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout_sharp),
          tooltip: 'Logout!',
          onPressed: () => {ref.read(authRepo).signOut()},
        ),
      ]),
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
          ref
              .read(userLogsProvider.notifier)
              .addUserLog(name: '김연구', date: DateTime.now());
        },
        child: const Text('출석'),
      ),
    );
  }
}
