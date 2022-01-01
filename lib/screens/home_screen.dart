import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';
import 'package:intl/intl.dart';

const Color _primaryColor = Colors.blue;
const Color _lightPrimaryColor = Colors.lightBlue;
const Color _darkPrimaryColor = Colors.indigo;
const Color _secondaryColor = Colors.green;

class Event {
  final String name;
  final String? note;
  final DateTime? from;
  final DateTime? to;

  const Event({required this.name, this.note, this.from, this.to});

  @override
  String toString() => name;
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final LinkedHashMap<DateTime, List<Event>> _events;
  late final ValueNotifier<List<Event>> _selectedEvents;

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _events = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: (key) => key.day * 1000000 + key.month * 10000 + key.year,
    );
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    List<DateTime> days = _daysInRange(start, end);
    return [for (final day in days) ..._getEventsForDay(day)];
  }

  List<DateTime> _daysInRange(DateTime first, DateTime last) {
    int dayCount = last.difference(first).inDays + 1;
    return List.generate(dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
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
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        _lightPrimaryColor,
                        _darkPrimaryColor,
                      ],
                    ),
                  ),
                  child: _calendar(),
                ),
                const Positioned(
                  bottom: -30,
                  right: 16,
                  child: AddEventButton(),
                )
              ],
              clipBehavior: Clip.none,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    DateFormat('EEEE, MMMM d').format(_selectedDay!),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: _eventList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ValueListenableBuilder<List<Event>> _eventList() {
    return ValueListenableBuilder<List<Event>>(
      valueListenable: _selectedEvents,
      builder: (context, value, child) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: value.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.fiber_manual_record,
                color: _secondaryColor,
              ),
              title: Text(
                value[index].name,
                style: const TextStyle(fontSize: 18.0),
              ),
              subtitle: Text(value[index].note ?? ''),
            );
          },
        );
      },
    );
  }

  SafeArea _calendar() {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Text('Loading');
          // }
          _events.clear();
          for (final doc in snapshot.data!.docs) {
            Map<String, dynamic> data = doc.data();
            DateTime dt = (data['time'] as Timestamp).toDate();
            Event newEvent = Event(name: data['event'], note: data['note']);
            if (_events.containsKey(dt)) {
              _events[dt]!.add(newEvent);
            } else {
              _events[dt] = [newEvent];
            }
          }
          return TableCalendar<Event>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2040, 1, 1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: _rangeSelectionMode,
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: true,
              selectedDecoration: BoxDecoration(
                color: _primaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: _lightPrimaryColor,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: _secondaryColor,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Colors.white,
              ),
              weekendStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            eventLoader: _getEventsForDay,
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          );
        },
      ),
    );
  }
}

class AddEventButton extends StatelessWidget {
  const AddEventButton({Key? key}) : super(key: key);

  void _eventPopup(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const EventPopup(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        opaque: false,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 200),
        maintainState: true,
        barrierColor: Colors.black54,
        barrierLabel: 'Event popup open',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _eventPopup(context),
      child: SizedBox(
        width: 130,
        height: 60,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _secondaryColor,
            borderRadius: BorderRadius.circular(36.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: const [
                Icon(
                  Icons.add_rounded,
                  size: 30.0,
                  color: Colors.white,
                ),
                Text(
                  'Event',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventPopup extends StatefulWidget {
  const EventPopup({Key? key}) : super(key: key);

  @override
  _EventPopupState createState() => _EventPopupState();
}

class _EventPopupState extends State<EventPopup> {
  CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  String? _event;
  String? _note;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'New event',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 5.0,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onChanged: (value) {
                      _event = value;
                    },
                  ),
                  const Divider(thickness: 0.2),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a note (optional)',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 5.0,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    maxLines: 6,
                    onChanged: (value) {
                      _note = value;
                    },
                  ),
                  const Divider(thickness: 0.2),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Time',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 5.0,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const Divider(thickness: 0.2),
                  GestureDetector(
                    onTap: () {
                      if (_event != null) {
                        eventsCollection.add({
                          'event': _event,
                          'note': _note ?? "",
                          // 'time': widget.day,
                        }).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: const Center(
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
