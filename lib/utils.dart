import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

// Calendar event class
class Event {
  final String title;
  final String note;

  const Event(this.title, this.note);

  @override
  String toString() => title;
}

// All events for calendar
final events = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: (key) => key.day * 1000000 + key.month * 10000 + key.year,
)..addAll(_eventSource);

// Temporary test events for calendar
final _eventSource = { for (var item in List.generate(50, (index) => index)) DateTime.utc(2021, 12, item * 5) : List.generate(
        item % 4 + 1, (index) => Event("Event $item | ${index + 1}", "")) };
