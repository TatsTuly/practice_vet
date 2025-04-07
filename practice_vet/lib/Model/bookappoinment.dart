import 'package:flutter/material.dart';
import 'package:practice_vet/Model/doctor.dart';

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
  String? _appointmentDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment with ${widget.doctor.name}"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Select Date",
                  hintText: "Select a date for the appointment",
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                  );
                  if (pickedDate != null && pickedDate != DateTime.now()) {
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
              const SizedBox(height: 20),

              // Time field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Select Time",
                  hintText: "Select time for the appointment",
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
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
              const SizedBox(height: 20),

              // Description field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Appointment Description",
                  hintText: "Tell us your reason for the appointment",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  _appointmentDescription = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide a description";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle the appointment booking logic
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Appointment Confirmed"),
                          content: Text(
                            "Your appointment with Dr. ${widget.doctor.name} is booked for $_selectedDate at $_selectedTime.\n\nDescription: $_appointmentDescription",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context); // Pop both the dialog and the appointment screen
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Confirm Appointment",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
