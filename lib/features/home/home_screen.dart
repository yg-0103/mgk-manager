import 'package:flutter/material.dart';
import 'package:mgk_manager/features/home/widgets/table_event_calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MGK'),
      ),
      body: const TableEventsCalender(),
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          fixedSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          print('pressed');
        },
        child: const Text('출석'),
      ),
    );
  }
}
