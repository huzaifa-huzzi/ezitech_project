
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AdminPanelController extends GetxController {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('attendance');

  var attendanceList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendance();
  }

  void fetchAttendance() {
    _ref.onValue.listen((event) {
      attendanceList.clear();
      if (event.snapshot.value != null) {
        Map data = event.snapshot.value as Map;
        data.forEach((key, value) {
          attendanceList.add({
            'key': key,
            ...value,
          });
        });
      }
    });
  }

  void deleteAttendance(String key) {
    _ref.child(key).remove();
  }

  void updateAttendance(String key, Map<String, String> updatedData) {
    _ref.child(key).update(updatedData);
  }
}
