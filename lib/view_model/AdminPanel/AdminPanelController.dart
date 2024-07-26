
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AdminPanelController extends GetxController {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('attendance');
  var attendanceList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadAttendanceData();
  }

  void _loadAttendanceData() {
    _ref.onValue.listen((event) {
      attendanceList.clear();
      if (event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        data.forEach((key, value) {
          final attendance = Map<String, dynamic>.from(value as Map);
          attendance['key'] = key;
          attendanceList.add(attendance);
        });
      }
    });
  }

  void updateAttendance(String key, Map<String, String> updatedData) {
    _ref.child(key).update(updatedData).then((_) {
      Get.snackbar('Success', 'Attendance updated successfully');
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to update attendance: $error');
    });
  }

  void approveLeave(String key) {
    updateAttendance(key, {'approvalStatus': 'Approved'});
  }

  void disapproveLeave(String key) {
    updateAttendance(key, {'approvalStatus': 'Disapproved'});
  }

  void deleteAttendance(String key) {
    _ref.child(key).remove().then((_) {
      Get.snackbar('Success', 'Attendance deleted successfully');
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to delete attendance: $error');
    });
  }
}
