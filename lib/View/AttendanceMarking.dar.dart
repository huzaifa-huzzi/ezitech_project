import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AttendanceMarking extends StatefulWidget {
  const AttendanceMarking({super.key});

  @override
  State<AttendanceMarking> createState() => _AttendanceMarkingState();
}

class _AttendanceMarkingState extends State<AttendanceMarking> {
  final _formKey = GlobalKey<FormState>();
  String? _attendanceStatus;
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _whyController = TextEditingController();
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('attendance');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance marking'),
        centerTitle: true,
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _attendanceStatus,
                hint: const Text('Select Attendance Status'),
                items: ['Present', 'Absent', 'Leave']
                    .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _attendanceStatus = value;
                  });
                },
                validator: (value) => value == null ? 'Please select an option' : null,
              ),
              if (_attendanceStatus == 'Present' || _attendanceStatus == 'Absent') ...[
                TextFormField(
                  controller: _dayController,
                  decoration: const InputDecoration(labelText: 'Day'),
                  validator: (value) => value!.isEmpty ? 'Please enter the day' : null,
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                  validator: (value) => value!.isEmpty ? 'Please enter the date' : null,
                ),
              ],
              if (_attendanceStatus == 'Leave') ...[
                TextFormField(
                  controller: _whyController,
                  decoration: const InputDecoration(
                    labelText: 'Why?',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) => value!.isEmpty ? 'Please enter the reason' : null,
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                  validator: (value) => value!.isEmpty ? 'Please enter the date' : null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }


  void _submitAttendance() {
    Map<String, String> attendanceData = {
      'status': _attendanceStatus!,
      'date': _dateController.text,
    };

    if (_attendanceStatus == 'Present' || _attendanceStatus == 'Absent') {
      attendanceData['day'] = _dayController.text;
    } else if (_attendanceStatus == 'Leave') {
      attendanceData['why'] = _whyController.text;
    }

    _ref.push().set(attendanceData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
       const  SnackBar(content: Text('Attendance marked successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark attendance: $error')),
      );
    });

    _resetForm();
  }

  void _resetForm() {
    setState(() {
      _attendanceStatus = null;
      _dayController.clear();
      _dateController.clear();
      _whyController.clear();
    });
  }

  @override
  void dispose() {
    _dayController.dispose();
    _dateController.dispose();
    _whyController.dispose();
    super.dispose();
  }
}
