import 'package:flutter/material.dart';
import 'package:practice_vet/Model/doctor.dart';
import '../veterinary_screen.dart';

class ListOfDoctor extends StatelessWidget {
  final Doctor doctor;
  const ListOfDoctor({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // Get available width to make widget responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with responsive size
          CircleAvatar(
            radius: isSmallScreen ? 35 : 40,
            backgroundColor: Color(doctor.color),
            backgroundImage: NetworkImage(doctor.image),
          ),
          const SizedBox(height: 12),
          
          // Doctor name with overflow handling
          Text(
            "Dr. ${doctor.name}",
            style: TextStyle(
              fontSize: isSmallScreen ? 15 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          
          // Specialist with overflow handling
          Text(
            doctor.specialist,
            style: TextStyle(
              fontSize: isSmallScreen ? 12 : 13,
              color: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          
          // Responsive wrapper for price
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "৳${doctor.price}",
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          
          // Animal types treated
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 4,
            children: doctor.treatsAnimals.take(2).map((animal) => 
              Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.cardColor,
                label: Text(
                  animal,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 10 : 11,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }
}