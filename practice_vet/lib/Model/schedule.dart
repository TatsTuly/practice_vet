import 'doctor.dart';

class Schedule {
  final Doctor doctor;
  final String status;
  final DateTime time;
  final String? petName;
  final String? petType;
  final String? reason;

  Schedule({
    required this.doctor,
    required this.status,
    required this.time,
    this.petName,
    this.petType,
    this.reason,
  });
}

// Initialize with empty list instead of dummy data
List<Schedule> schedules = [];

// Tabs for UI
List<String> tabs = ['Upcoming', 'Completed', 'Cancelled'];

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
