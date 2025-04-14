import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/schedule.dart';

// Define app theme colors - matching with veterinary_screen.dart
class AppColors {
  static const Color primaryColor = Color(0xFF8E24AA); // Deep purple pink
  static const Color primaryLight = Color(0xFFC158DC); // Lighter purple pink
  static const Color primaryDark = Color(0xFF5C007A);  // Darker purple pink
  static const Color accentColor = Color(0xFFE91E63); // Pink accent
  static const Color cardColor = Color(0xFFF3E5F5); // Very light purple background
  static Color shadowColor = Colors.purple.withOpacity(0.15);
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date for comparison
    final now = DateTime.now();
    
    // Filter schedules by status
    List<Schedule> upcoming = schedules
        .where((s) => s.status.toLowerCase() == 'upcoming')
        .toList()
      ..sort((a, b) => a.time.compareTo(b.time)); // Sort by date
    
    List<Schedule> completed = schedules
        .where((s) => s.status.toLowerCase() == 'completed')
        .toList()
      ..sort((a, b) => b.time.compareTo(a.time)); // Most recent first
    
    List<Schedule> cancelled = schedules
        .where((s) => s.status.toLowerCase() == 'cancelled')
        .toList()
      ..sort((a, b) => b.time.compareTo(a.time)); // Most recent first

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Pet Appointments",
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Today's date display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Today: ${DateFormat('EEEE, MMMM d, y').format(now)}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Custom tab bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.cardColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              padding: const EdgeInsets.all(4),
              tabs: const [
                Tab(text: "Upcoming"),
                Tab(text: "Completed"),
                Tab(text: "Cancelled"),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildScheduleList(upcoming),
                _buildScheduleList(completed),
                _buildScheduleList(cancelled),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleList(List<Schedule> list) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets, size: 60, color: AppColors.primaryLight.withOpacity(0.3)),
            const SizedBox(height: 16),
            const Text(
              "No appointments here yet", 
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (_tabController.index == 0) // Only show this button for the Upcoming tab
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to home screen (index 0)
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.add),
                label: const Text("Book New Appointment"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final schedule = list[index];
        final doctor = schedule.doctor;
        
        // Format date and time
        String formattedDate;
        String formattedTime;
        
        try {
          formattedDate = DateFormat('EEE, MMM d, yyyy').format(schedule.time);
          formattedTime = DateFormat('h:mm a').format(schedule.time);
        } catch (e) {
          // Fallback if formatting fails
          formattedDate = schedule.time.toString().split(' ')[0];
          formattedTime = schedule.time.toString().split(' ')[1].substring(0, 5);
        }
        
        // Check if appointment is today
        final isToday = DateTime(
          schedule.time.year,
          schedule.time.month,
          schedule.time.day,
        ).isAtSameMomentAs(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ));
        
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date badge for upcoming appointments
                if (schedule.status.toLowerCase() == 'upcoming' && isToday)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryLight),
                    ),
                    child: const Text(
                      "TODAY",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                
                // Vet and status info
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(doctor.image),
                      radius: 30,
                      backgroundColor: Color(doctor.color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            doctor.specialist,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(schedule.status),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        schedule.status.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const Divider(height: 24),
                
                // Pet info
                Row(
                  children: [
                    const Icon(Icons.pets, color: AppColors.accentColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "${schedule.petName ?? 'Pet'} (${schedule.petType ?? 'Unknown'})",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Date and time
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: AppColors.primaryColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time, color: AppColors.primaryColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      formattedTime,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Reason for visit
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.note, color: AppColors.primaryColor, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        schedule.reason ?? "No reason provided",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                
                // Action buttons for upcoming appointments
                if (schedule.status.toLowerCase() == 'upcoming')
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            _showRescheduleDialog(context, schedule);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryColor,
                            side: const BorderSide(color: AppColors.primaryColor),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          child: const Text("Reschedule"),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {
                            _showCancelDialog(context, schedule);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.accentColor,
                            side: const BorderSide(color: AppColors.accentColor),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return AppColors.primaryColor;
      case 'completed':
        return const Color(0xFF2196F3); // Blue
      case 'cancelled':
        return AppColors.accentColor; // Pink accent color for cancelled
      default:
        return Colors.grey;
    }
  }
  
  // Dialog to confirm appointment cancellation
  void _showCancelDialog(BuildContext context, Schedule schedule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cancel Appointment", style: TextStyle(color: AppColors.primaryDark)),
        content: Text(
          "Are you sure you want to cancel your appointment with Dr. ${schedule.doctor.name} for ${schedule.petName}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[700],
            ),
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              // Update the schedule status
              setState(() {
                for (int i = 0; i < schedules.length; i++) {
                  if (schedules[i] == schedule) {
                    // Create a new schedule with cancelled status
                    schedules[i] = Schedule(
                      doctor: schedule.doctor,
                      status: 'cancelled',
                      time: schedule.time,
                      petName: schedule.petName,
                      petType: schedule.petType,
                      reason: schedule.reason,
                    );
                    break;
                  }
                }
              });
              
              Navigator.pop(context);
              
              // Show confirmation
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment cancelled successfully'),
                  backgroundColor: AppColors.accentColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentColor,
              foregroundColor: Colors.white,
            ),
            child: const Text("Yes, Cancel"),
          ),
        ],
      ),
    );
  }
  
  // Dialog to reschedule appointment
  void _showRescheduleDialog(BuildContext context, Schedule schedule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reschedule Appointment", 
          style: TextStyle(color: AppColors.primaryDark)),
        content: const Text(
          "This feature will be available soon. Please contact the clinic directly to reschedule your appointment.",
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
