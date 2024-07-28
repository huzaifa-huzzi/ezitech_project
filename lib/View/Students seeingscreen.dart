import 'package:ezitech_project_1/view_model/AdminPanel/AdminPanelController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentAttendanceScreen extends StatelessWidget {
  final AdminPanelController controller = Get.put(AdminPanelController());

  double calculatePresencePercentage(List<Map<String, dynamic>> attendanceList) {
    int presentCount = attendanceList.where((attendance) => attendance['status'] == 'Present').length;
    return attendanceList.isNotEmpty ? (presentCount / attendanceList.length) * 100 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance Records'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.attendanceList.length,
                itemBuilder: (context, index) {
                  final attendance = controller.attendanceList[index];

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Date: ${attendance['date']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status: ${attendance['status']}'),
                          if (attendance['status'] == 'Present' || attendance['status'] == 'Absent')
                            Text('Day: ${attendance['day']}'),
                          if (attendance['status'] == 'Leave')
                            Text('Reason: ${attendance['why']}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Obx(() {
            double percentage = calculatePresencePercentage(controller.attendanceList);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Presence Percentage: ${percentage.toStringAsFixed(2)}%'),
            );
          }),
        ],
      ),
    );
  }
}
