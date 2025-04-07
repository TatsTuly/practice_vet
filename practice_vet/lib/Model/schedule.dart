import 'doctor.dart';

class Schedule {
  final Doctor doctor;
  final String status;
  final DateTime time;

  Schedule({
    required this.doctor,
    required this.status,
    required this.time,
  });
}

// Sample list of schedules
List<Schedule> schedules = [
  Schedule(
    doctor: doctors[4],
    status: 'Confirmed',
    time: DateTime.parse('2024-11-03'),
  ),
  Schedule(
    doctor: doctors[0],
    status: 'Confirmed',
    time: DateTime.parse('2024-11-04'),
  ),
  Schedule(
    doctor: doctors[1],
    status: 'Confirmed',
    time: DateTime.parse('2024-11-05 09:30'),
  ),
  Schedule(
    doctor: doctors[2],
    status: 'Confirmed',
    time: DateTime.parse('2024-11-01 06:00'),
  ),
  Schedule(
    doctor: doctors[3],
    status: 'Confirmed',
    time: DateTime.parse('2024-11-06 15:45'),
  ),
];

// Tabs for UI
List<String> tabs = ['Upcoming', 'Completed', 'Canceled'];

// Get current date without time component
DateTime now = DateTime.now();
DateTime today = DateTime(now.year, now.month, now.day);

// Filter schedules occurring today
List<Schedule> nearest = schedules.where((schedule) {
  DateTime scheduleDate = DateTime(
    schedule.time.year,
    schedule.time.month,
    schedule.time.day,
  );
  return scheduleDate.isAtSameMomentAs(today);
}).toList();

// Filter future schedules
List<Schedule> futures = schedules.where((schedule) {
  return schedule.time.isAfter(now);
}).toList();
