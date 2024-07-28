import 'package:ezitech_project_1/Routes/Routes_name.dart';
import 'package:ezitech_project_1/view_model/attendaceMaking/AttendaneakingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceMarking extends StatefulWidget {
  const AttendanceMarking({super.key});

  @override
  State<AttendanceMarking> createState() => _AttendanceMarkingState();
}

class _AttendanceMarkingState extends State<AttendanceMarking> {
  final AttendanceMarkingController _controller = Get.put(AttendanceMarkingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Panel'),
        centerTitle: true,
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: (){
                Get.toNamed(RouteName.loginScreen);
              },
              child:const  Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _controller.pickImage(),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _controller.imageUrl.value.isNotEmpty
                        ? NetworkImage(_controller.imageUrl.value)
                        : null,
                    backgroundColor: Colors.grey[300],
                    child: _controller.imageUrl.value.isEmpty
                        ? const Icon(Icons.camera_alt, size: 50, color: Colors.black45)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _controller.attendanceStatus.value.isNotEmpty
                      ? _controller.attendanceStatus.value
                      : null,
                  hint: const Text('Select Attendance Status'),
                  items: ['Present', 'Absent', 'Leave']
                      .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ))
                      .toList(),
                  onChanged: (value) {
                    _controller.attendanceStatus.value = value ?? '';
                  },
                  validator: (value) => value == null ? 'Please select an option' : null,
                ),
                if (_controller.attendanceStatus.value == 'Present' || _controller.attendanceStatus.value == 'Absent') ...[
                  TextFormField(
                    controller: _controller.dayController,
                    decoration: const InputDecoration(labelText: 'Day'),
                    validator: (value) => value!.isEmpty ? 'Please enter the day' : null,
                  ),
                  TextFormField(
                    controller: _controller.dateController,
                    decoration: const InputDecoration(labelText: 'Date'),
                    validator: (value) => value!.isEmpty ? 'Please enter the date' : null,
                  ),
                ],
                if (_controller.attendanceStatus.value == 'Leave') ...[
                  TextFormField(
                    controller: _controller.whyController,
                    decoration: const InputDecoration(
                      labelText: 'Why?',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    validator: (value) => value!.isEmpty ? 'Please enter the reason' : null,
                  ),
                  TextFormField(
                    controller: _controller.dateController,
                    decoration: const InputDecoration(labelText: 'Date'),
                    validator: (value) => value!.isEmpty ? 'Please enter the date' : null,
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.formKey.currentState!.validate()) {
                      _controller.submitAttendance(context);
                    }
                  },
                  child: const Text('Submit Attendance'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RouteName.studentSeeing);
                  },
                  child: const Text('View My Attendance'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
