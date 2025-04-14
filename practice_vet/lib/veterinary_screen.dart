import 'package:flutter/material.dart';
import 'package:practice_vet/Model/doctor.dart';
import 'package:practice_vet/Widgets/list_of_doctor.dart';
import 'package:practice_vet/doctor_detail_screen.dart';
import 'package:practice_vet/schedule_screen.dart';

// Global key to access VeterinaryScreen state from anywhere
final GlobalKey<_VeterinaryScreenState> vetScreenKey = GlobalKey<_VeterinaryScreenState>();

// Define app theme colors
class AppColors {
  static const Color primaryColor = Color(0xFF8E24AA); // Deep purple pink
  static const Color primaryLight = Color(0xFFC158DC); // Lighter purple pink
  static const Color primaryDark = Color(0xFF5C007A);  // Darker purple pink
  static const Color accentColor = Color(0xFFE91E63); // Pink accent
  static const Color cardColor = Color(0xFFF3E5F5); // Very light purple background
  static Color shadowColor = Colors.purple.withOpacity(0.15);
}

class VeterinaryScreen extends StatefulWidget {
  const VeterinaryScreen({Key? key}) : super(key: vetScreenKey);

  @override
  State<VeterinaryScreen> createState() => _VeterinaryScreenState();
}

class VeterinaryApp extends StatelessWidget {
  const VeterinaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.accentColor,
          tertiary: AppColors.primaryLight,
          surface: AppColors.cardColor.withOpacity(0.5),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            side: const BorderSide(color: AppColors.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const VeterinaryScreen(),
    );
  }
}

class _VeterinaryScreenState extends State<VeterinaryScreen> {
  int _selectedIndex = 0;
  
  // Method to change tabs programmatically from external screens
  void changeTab(int index) {
    if (index >= 0 && index < 2) {  // We have 2 tabs (0: Veterinarians, 1: Appointments)
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedIndex == 0 ? _buildHomeScreen() : const ScheduleScreen(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.pets_outlined),
              activeIcon: Icon(Icons.pets),
              label: "Veterinarians",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: "Appointments",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        // Custom App Bar with dark purple theme
        Container(
          color: AppColors.primaryDark,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Veterinary Support",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Find the right vet for your pet",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/portrait-3d-female-doctor_23-2151107332.jpg",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Main Content
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildServiceOptions(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Available Veterinarians",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildVetListFixed(),
              // Add padding at the bottom to ensure nothing is cut off
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for veterinarians, specialties...",
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: AppColors.cardColor.withOpacity(0.5),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryLight, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceOptions() {
    return SizedBox(
      height: 90, // Reduced height from 110 to 90
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: [
          _buildServiceCard(
            title: "Clinic",
            icon: Icons.medical_services_outlined,
            color: const Color.fromARGB(255, 214, 108, 244),
          ),
          _buildServiceCard(
            title: "Home",
            icon: Icons.home_outlined,
            color: const Color.fromARGB(255, 228, 110, 149),
          ),
          _buildServiceCard(
            title: "Vaccine",
            icon: Icons.healing_outlined,
            color: const Color.fromARGB(255, 131, 133, 235),
          ),
          _buildServiceCard(
            title: "Surgery",
            icon: Icons.local_hospital_outlined,
            color: const Color.fromARGB(255, 228, 128, 153),
          ),
          _buildServiceCard(
            title: "Checkup",
            icon: Icons.pets_rounded,
            color: Color.fromARGB(255, 133, 216, 235), // Teal color
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 80, // Reduced width from 100 to 80
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withOpacity(0.3)),
        ),
        color: color.withOpacity(0.08),
        child: Padding(
          padding: const EdgeInsets.all(8), // Reduced padding from 12 to 8
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 18, // Reduced radius from 20 to 18
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color, size: 18), // Reduced size from 22 to 18
              ),
              const SizedBox(height: 6), // Reduced spacing from 8 to 6
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11, // Reduced font size from 12 to 11
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fixed version of vet list that won't overflow
  Widget _buildVetListFixed() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 380;
    
    // Calculate ideal height based on device
    final double cardHeight = isSmallScreen ? 235 : 255;
    
    // Calculate how many rows we need (each row has 2 items)
    final int rowCount = (doctors.length / 2).ceil();
    
    // Calculate total height needed
    final double gridHeight = rowCount * cardHeight;
    
    return SizedBox(
      height: gridHeight,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const NeverScrollableScrollPhysics(), // Disable scroll within grid
        itemCount: doctors.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: isSmallScreen ? 0.8 : 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
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
          );
        },
      ),
    );
  }
}