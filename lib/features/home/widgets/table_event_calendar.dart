import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Event {
  final String name;
  final DateTime date;
  const Event({required this.name, required this.date});

  @override
  String toString() => name;
}

class TableEventsCalender extends StatefulWidget {
  final Map<String, dynamic> userLogs;
  const TableEventsCalender({required this.userLogs, super.key});

  @override
  _TableEventsCalenderState createState() => _TableEventsCalenderState();
}

class _TableEventsCalenderState extends State<TableEventsCalender> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  dynamic getLog({required String name, required DateTime day}) {
    if (widget.userLogs[name] == null) return null;
    for (var log in widget.userLogs[name]!) {
      if ('${day.month}/${day.day}' ==
          '${log.toDate().month}/${log.toDate().day}') {
        return log;
      }
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> events = [];
    var kimLog = getLog(day: day, name: '김연구');
    var hanLog = getLog(day: day, name: '한지선');
    var songLog = getLog(day: day, name: '송준호');
    var kwonLog = getLog(day: day, name: '권은비');

    if (kimLog is Timestamp) {
      events.add(Event(name: '김연구', date: day.toLocal()));
    }
    if (hanLog is Timestamp) {
      events.add(Event(name: '한지선', date: day.toLocal()));
    }
    if (songLog is Timestamp) {
      events.add(Event(name: '송준호', date: day.toLocal()));
    }
    if (kwonLog is Timestamp) {
      events.add(Event(name: '권은비', date: day.toLocal()));
    }
    return events;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  Color getColor(String name) {
    switch (name) {
      case '김연구':
        return const Color(0xffff5252);
      case '한지선':
        return Colors.blue;

      case '송준호':
        return Colors.green;

      case '권은비':
        return Colors.purple;

      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime(2023, 6, 1),
            lastDay: DateTime(
                _focusedDay.year + 1, _focusedDay.month, _focusedDay.day),
            focusedDay: _focusedDay,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(
                color: Colors.red,
              ),
            ),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 52,
                    ),
                    Wrap(
                      verticalDirection: VerticalDirection.down,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      spacing: 2,
                      runSpacing: 8,
                      children: [
                        for (var event in events)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: getColor(event.name),
                            ),
                            width: 7,
                            height: 7,
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: Colors.lightBlue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.lightBlue.shade200,
                shape: BoxShape.circle,
              ),
              cellMargin: const EdgeInsets.all(10),
              cellAlignment: Alignment.center,
              markersMaxCount: 2,
            ),
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            rowHeight: 60,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: getColor(
                            value[index].name,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: getColor(value[index].name),
                          ),
                          width: 20,
                          height: 20,
                        ),
                        onTap: () => print('${value[index]}'),
                        title: Text(
                            '${value[index].name} ${DateFormat('MM/dd hh:mm').format(value[index].date)}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
