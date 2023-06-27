import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Event {
  final String name;
  final DateTime date;
  const Event(this.name, this.date);

  @override
  String toString() => name;
}

class TableEventsCalender extends StatefulWidget {
  const TableEventsCalender({super.key});

  @override
  _TableEventsCalenderState createState() => _TableEventsCalenderState();
}

class _TableEventsCalenderState extends State<TableEventsCalender> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<DateTime> kim = [
    DateTime(2023, 6, 1),
    DateTime(2023, 6, 10),
    DateTime(2023, 6, 20)
  ];
  List<DateTime> song = [
    DateTime(2023, 6, 1),
    DateTime(2023, 6, 4),
    DateTime(2023, 6, 13),
    DateTime(2023, 6, 22)
  ];
  List<DateTime> han = [
    DateTime(2023, 6, 1),
    DateTime(2023, 6, 6),
    DateTime(2023, 6, 16),
    DateTime(2023, 6, 22)
  ];
  List<DateTime> kwon = [
    DateTime(2023, 6, 1),
    DateTime(2023, 6, 8),
    DateTime(2023, 6, 12),
    DateTime(2023, 6, 28)
  ];
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

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> events = [];
    if (kim.contains(DateTime(day.year, day.month, day.day))) {
      events.add(
        Event('김연구', day.toLocal()),
      );
    }
    if (han.contains(DateTime(day.year, day.month, day.day))) {
      events.add(Event('한지선', day.toLocal()));
    }
    if (song.contains(DateTime(day.year, day.month, day.day))) {
      events.add(Event('송준호', day.toLocal()));
    }
    if (kwon.contains(DateTime(day.year, day.month, day.day))) {
      events.add(Event('권은비', day.toLocal()));
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

  MaterialColor getColor(String name) {
    switch (name) {
      case '김연구':
        return Colors.red;
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
                        border: Border.all(),
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
