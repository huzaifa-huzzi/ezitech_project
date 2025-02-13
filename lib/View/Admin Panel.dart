import 'package:ezitech_project_1/Routes/Routes_name.dart';
import 'package:ezitech_project_1/view_model/AdminPanel/AdminPanelController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPanel extends StatelessWidget {
  final AdminPanelController controller = Get.put(AdminPanelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: [
          InkWell(
              onTap: (){
                Get.toNamed(RouteName.loginScreen);
              },
              child:const  Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.attendanceList.length,
                itemBuilder: (context, index) {
                  final attendance = controller.attendanceList[index];
                  Color cardColor;

                  if (attendance['status'] == 'Leave') {
                    cardColor = attendance['approvalStatus'] == 'Approved'
                        ? Colors.green
                        : attendance['approvalStatus'] == 'Disapproved'
                        ? Colors.red
                        : Colors.yellow;
                  } else {
                    cardColor = Colors.white;
                  }

                  return Card(
                    color: cardColor,
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
                      trailing: Wrap(
                        spacing: 8.0,
                        children: [
                          if (attendance['status'] == 'Leave' && attendance['approvalStatus'] == 'Pending') ...[
                            IconButton(
                              icon: const Icon(Icons.check),
                              onPressed: () => controller.approveLeave(attendance['key']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => controller.disapproveLeave(attendance['key']),
                            ),
                          ],
                          if (attendance['status'] == 'Present' || attendance['status'] == 'Absent') ...[
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => controller.editAttendance(attendance['key'], context),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => controller.deleteAttendance(attendance['key']),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
