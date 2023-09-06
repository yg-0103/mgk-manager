import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mgk_manager/features/authentication/authentication_repo.dart';
import 'package:mgk_manager/features/authentication/user_models/user_logs_model.dart';
import 'package:mgk_manager/features/authentication/user_repo.dart';
import 'package:mgk_manager/features/authentication/view_models/user_view_model.dart';
import 'package:mgk_manager/features/home/widgets/table_event_calendar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLogs = ref.watch(userRepo).getUsersLog();
    return ref.watch(usersProvider).when(
        error: (error, stackTrace) {
          print(error);
          return Text('$error', style: const TextStyle(color: Colors.white));
        },
        loading: () => const CircularProgressIndicator.adaptive(),
        data: (data) => FutureBuilder(
              future: userLogs,
              builder: (context, snapshot) {
                if (snapshot.hasData == false) return Container();
                return Scaffold(
                  appBar: AppBar(
                    title: Text(data.name),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.logout_sharp),
                        tooltip: 'Logout!',
                        onPressed: () => {ref.read(authRepo).signOut()},
                      ),
                    ],
                  ),
                  body: TableEventsCalender(
                    userLogs: snapshot.data!,
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
                      var userLogModel = UserLogsModel(
                          userColor: data.userColor,
                          name: data.name,
                          userId: data.userId,
                          date: [DateTime.now()]);
                      ref.read(userRepo).updateLog(userLogModel).then(
                        (value) {
                          ref.refresh(userRepo);
                        },
                      );
                    },
                    child: const Text('출석'),
                  ),
                );
              },
            ));
  }
}
