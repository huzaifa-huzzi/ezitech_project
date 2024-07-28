import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class AttendanceMarkingController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final attendanceStatus = ''.obs;
  final TextEditingController dayController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController whyController = TextEditingController();
  final imageUrl = ''.obs;
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('attendance');

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String uploadedImageUrl = await _uploadImage(File(image.path));
      imageUrl.value = uploadedImageUrl;
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('attendance_images/${DateTime.now().toIso8601String()}');
    final UploadTask uploadTask = storageRef.putFile(imageFile);

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void submitAttendance(BuildContext context) {
    if (attendanceStatus.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select attendance status')),
      );
      return;
    }

    Map<String, String> attendanceData = {
      'status': attendanceStatus.value,
      'date': dateController.text,
      'imageUrl': imageUrl.value,
    };

    if (attendanceStatus.value == 'Present' || attendanceStatus.value == 'Absent') {
      attendanceData['day'] = dayController.text;
    } else if (attendanceStatus.value == 'Leave') {
      attendanceData['why'] = whyController.text;
      attendanceData['approvalStatus'] = 'Pending';
    }

    _ref.push().set(attendanceData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance marked successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark attendance: $error')),
      );
    });

    resetForm();
  }

  void resetForm() {
    attendanceStatus.value = '';
    dayController.clear();
    dateController.clear();
    whyController.clear();
    imageUrl.value = '';
  }

  @override
  void onClose() {
    dayController.dispose();
    dateController.dispose();
    whyController.dispose();
    super.onClose();
  }
}
