import 'package:flutter/material.dart';


class AttendanceMarking extends StatefulWidget {
  const AttendanceMarking({super.key});

  @override
  State<AttendanceMarking> createState() => _AttendanceMarkingState();
}

class _AttendanceMarkingState extends State<AttendanceMarking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Attendance marking'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
    );
  }
}
