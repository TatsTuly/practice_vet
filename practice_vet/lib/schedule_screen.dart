import 'package:flutter/material.dart';
import '../Model/schedule.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Schedule> upcoming = schedules.where((s) => s.status == 'upcoming').toList();
    List<Schedule> completed = schedules.where((s) => s.status == 'completed').toList();
    List<Schedule> canceled = schedules.where((s) => s.status == 'cancelled').toList();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Appointments",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildTabBar(),
                const SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildScheduleList(upcoming),
                      _buildScheduleList(completed),
                      _buildScheduleList(canceled),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black54,
        tabs: const [
          Tab(text: "Upcoming"),
          Tab(text: "Completed"),
          Tab(text: "Canceled"),
        ],
      ),
    );
  }

  Widget _buildScheduleList(List<Schedule> list) {
    if (list.isEmpty) {
      return const Center(
        child: Text("No appointments here yet", style: TextStyle(color: Colors.black54)),
      );
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final schedule = list[index];
        final doctor = schedule.doctor;

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(doctor.image),
              radius: 30,
            ),
            title: Text(doctor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Time: ${schedule.time}"),
                Text("Status: ${schedule.status}"),
                Text("Location: ${doctor.location}"),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // Add navigation or detail popup if needed
            },
          ),
        );
      },
    );
  }
}
