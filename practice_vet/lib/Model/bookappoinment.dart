import 'package:flutter/material.dart';
import 'package:practice_vet/Model/doctor.dart';
import 'package:practice_vet/Model/schedule.dart';
import 'package:practice_vet/veterinary_screen.dart'; // Import for vetScreenKey

// Define consistent app colors matching the rest of the app
class AppColors {
  static const Color primaryColor = Color(0xFF8E24AA); // Deep purple pink
  static const Color primaryLight = Color(0xFFC158DC); // Lighter purple pink
  static const Color primaryDark = Color(0xFF5C007A);  // Darker purple pink
  static const Color accentColor = Color(0xFFE91E63); // Pink accent
  static const Color cardColor = Color(0xFFF3E5F5); // Very light purple background
  static Color shadowColor = Colors.purple.withOpacity(0.15);
}

class BookAppointmentScreen extends StatefulWidget {
  final Doctor doctor;

  const BookAppointmentScreen({
    super.key,
    required this.doctor,
  });

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDate;
  String? _selectedTime;
  String? _petName;
  String? _selectedPetType;
  String? _appointmentReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book with ${widget.doctor.name}"),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pet Name field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Pet Name",
                    prefixIcon: const Icon(Icons.pets, color: AppColors.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                    ),
                    floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    _petName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your pet's name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Pet Type dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Pet Type",
                    prefixIcon: const Icon(Icons.category, color: AppColors.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                    ),
                    floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: widget.doctor.treatsAnimals.map((animal) {
                    return DropdownMenuItem(
                      value: animal,
                      child: Text(animal),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPetType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select your pet type";
                    }
                    return null;
                  },
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                  dropdownColor: Colors.white,
                ),
                const SizedBox(height: 16),

                // Date field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Appointment Date",
                    prefixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                    ),
                    floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                  ),
                  readOnly: true,
                  controller: TextEditingController(text: _selectedDate),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppColors.primaryColor,
                              onPrimary: Colors.white,
                              surface: Colors.white,
                              onSurface: AppColors.primaryDark,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = "${pickedDate.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a date";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Time field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Appointment Time",
                    prefixIcon: const Icon(Icons.access_time, color: AppColors.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                    ),
                    floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                  ),
                  readOnly: true,
                  controller: TextEditingController(text: _selectedTime),
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppColors.primaryColor,
                              onPrimary: Colors.white,
                              surface: Colors.white,
                              onSurface: AppColors.primaryDark,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _selectedTime = pickedTime.format(context);
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a time";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Reason field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Reason for Visit",
                    prefixIcon: const Icon(Icons.note_alt, color: AppColors.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                    ),
                    floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Describe your pet's symptoms or reason for visit",
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    _appointmentReason = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please provide a reason for your visit";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Create a new appointment
                        String timeString = _selectedTime?.split(" ")[0] ?? "00:00";
                        if (timeString.split(":").length == 2) {
                          timeString = "$timeString:00";
                        }
                        
                        final DateTime appointmentDateTime = DateTime.parse(
                          "$_selectedDate $timeString"
                        );
                        
                        // Add to schedules in memory
                        schedules.add(
                          Schedule(
                            doctor: widget.doctor,
                            status: 'upcoming',
                            time: appointmentDateTime,
                            petName: _petName!,
                            petType: _selectedPetType!,
                            reason: _appointmentReason!,
                          ),
                        );
                        
                        // Show confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Appointment booked successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        
                        // Pop back to the veterinary screen
                        Navigator.pop(context);
                        
                        // Navigate to appointments tab using the global key
                        if (vetScreenKey.currentState != null) {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            vetScreenKey.currentState!.changeTab(1);
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      "Book Appointment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
