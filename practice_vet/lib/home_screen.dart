import 'package:flutter/material.dart';
import 'package:practice_vet/Model/doctor.dart';
import 'package:practice_vet/Widgets/list_of_doctor.dart';
import 'package:practice_vet/doctor_detail_screen.dart';

class VetHomeScreen extends StatefulWidget {
  const VetHomeScreen({super.key});

  @override
  State<VetHomeScreen> createState() =>
      _DoctorAppoinmentHomeScreenState();
}

class _DoctorAppoinmentHomeScreenState
    extends State<VetHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildClinicAndHomeVisit(),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Popular Vets",
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                letterSpacing: -.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              child: Wrap(
                runSpacing: 14,
                spacing: 16,
                children: [
                  ...List.generate(
                    doctors.length,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DoctorDetailScreen(
                              doctor: doctors[index],
                            ),
                          ),
                        );
                      },
                      child: ListOfDoctor(
                        doctor: doctors[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Hi Tanjina",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
             
            ],
          ),
          const CircleAvatar(
            radius: 25,

            backgroundImage: NetworkImage(
              "https://img.freepik.com/free-photo/portrait-3d-female-doctor_23-2151107332.jpg",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for a doctor...",
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildClinicAndHomeVisit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: _buildVisitCard(
              color: Colors.purple,
              icon: Icons.add_circle,
              title: "Clinic Visit",
              subtitle: "Make an appointment",
              iconColor: Colors.white,
              textColor: Colors.white,
              subTextColor: Colors.white70,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildVisitCard(
              color: Colors.white,
              icon: Icons.home_filled,
              title: "Home Visit",
              subtitle: "Call doctor home",
              iconColor: Colors.purple,
              textColor: Colors.black,
              subTextColor: Colors.black45,
              hasShadow: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitCard({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color textColor,
    required Color subTextColor,
    bool hasShadow = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                )
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: iconColor),
          const SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              fontFamily: "Playfair",
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: "Playfair",
              color: subTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
