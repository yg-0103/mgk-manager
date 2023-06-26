import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils.dart';

class TableEventsExample extends StatefulWidget {
  const TableEventsExample({super.key});

  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<DateTime> kim = [
    DateTime(2023, 6, 1),
    DateTime(2023, 6, 10),
    DateTime(2023, 6, 20)
  ];
  List<DateTime> song = [
    DateTime(2023, 6, 4),
    DateTime(2023, 6, 13),
    DateTime(2023, 6, 22)
  ];
  List<DateTime> han = [
    DateTime(2023, 6, 6),
    DateTime(2023, 6, 16),
    DateTime(2023, 6, 22)
  ];
  List<DateTime> kwon = [
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
    if (kim.contains(DateTime(day.year, day.month, day.day))) {
      return [Event('김연구 ${day.toLocal()}')];
    }
    if (han.contains(DateTime(day.year, day.month, day.day))) {
      return [Event('한지선  ${day.toLocal()}')];
    }
    if (song.contains(DateTime(day.year, day.month, day.day))) {
      return [Event('송준호  ${day.toLocal()}')];
    }
    if (kwon.contains(DateTime(day.year, day.month, day.day))) {
      return [Event('권은비  ${day.toLocal()}')];
    }
    return [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    return [const Event('hi')];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MGK'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                return Row(
                  children: [for (var event in events) Text('$event')],
                );
              },
            ),
            calendarStyle: const CalendarStyle(
              markerSize: 10,
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
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
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
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
