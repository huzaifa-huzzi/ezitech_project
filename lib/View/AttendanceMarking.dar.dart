import 'package:ezitech_project_1/view_model/attendaceMaking/AttendaneakingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceMarking extends StatefulWidget {
  const AttendanceMarking({super.key});

  @override
  State<AttendanceMarking> createState() => _AttendanceMarkingState();
}

class _AttendanceMarkingState extends State<AttendanceMarking> {
  final _formKey = GlobalKey<FormState>();
  final AttendanceMarkingController _controller = Get.put(AttendanceMarkingController());

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
          child: GetBuilder<AttendanceMarkingController>(
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButtonFormField<String>(
                    value: controller.attendanceStatus,
                    hint: const Text('Select Attendance Status'),
                    items: ['Present', 'Absent', 'Leave']
                        .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.attendanceStatus = value;
                      controller.update();
                    },
                    validator: (value) => value == null ? 'Please select an option' : null,
                  ),
                  if (controller.attendanceStatus == 'Present' || controller.attendanceStatus == 'Absent') ...[
                    TextFormField(
                      controller: controller.dayController,
                      decoration: const InputDecoration(labelText: 'Day'),
                      validator: (value) => value!.isEmpty ? 'Please enter the day' : null,
                    ),
                    TextFormField(
                      controller: controller.dateController,
                      decoration: const InputDecoration(labelText: 'Date'),
                      validator: (value) => value!.isEmpty ? 'Please enter the date' : null,
                    ),
                  ],
                  if (controller.attendanceStatus == 'Leave') ...[
                    TextFormField(
                      controller: controller.whyController,
                      decoration: const InputDecoration(
                        labelText: 'Why?',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      validator: (value) => value!.isEmpty ? 'Please enter the reason' : null,
                    ),
                    TextFormField(
                      controller: controller.dateController,
                      decoration: const InputDecoration(labelText: 'Date'),
                      validator: (value) => value!.isEmpty ? 'Please enter the date' : null,
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _controller.submitAttendance(context);
          }
        },
        child: const Icon(Icons.check,color: Colors.white,),
      ),
    );
  }
}
