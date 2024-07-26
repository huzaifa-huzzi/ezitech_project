import 'package:ezitech_project_1/view_model/AdminPanel/AdminPanelController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPanel extends StatelessWidget {

  final AdminPanelController controller = Get.put(AdminPanelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Obx(() {
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showEditDialog(context, attendance),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => controller.deleteAttendance(attendance['key']),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> attendance) {
    final statusController = TextEditingController(text: attendance['status']);
    final dayController = TextEditingController(text: attendance['day'] ?? '');
    final dateController = TextEditingController(text: attendance['date']);
    final whyController = TextEditingController(text: attendance['why'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Attendance'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: statusController,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              if (attendance['status'] == 'Present' || attendance['status'] == 'Absent')
                TextFormField(
                  controller: dayController,
                  decoration: const InputDecoration(labelText: 'Day'),
                ),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
              if (attendance['status'] == 'Leave')
                TextFormField(
                  controller: whyController,
                  decoration: const InputDecoration(labelText: 'Reason'),
                  maxLines: 4,
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedData = {
                  'status': statusController.text,
                  'date': dateController.text,
                };
                if (attendance['status'] == 'Present' || attendance['status'] == 'Absent') {
                  updatedData['day'] = dayController.text;
                }
                if (attendance['status'] == 'Leave') {
                  updatedData['why'] = whyController.text;
                }
                controller.updateAttendance(attendance['key'], updatedData);
                Get.back();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
