import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      final String? userEmail = _auth.currentUser?.email;
      if (userEmail != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('user')
            .where('username', isEqualTo: userEmail)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          final userDataMap = snapshot.docs.first.data();
          userData.value = userDataMap;
        } else {
          print('User not found');
        }
      } else {
        print('User not authenticated');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> uploadProfileImage() async {
    try {
      final XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImage != null) {
        final User? user = _auth.currentUser;
        if (user != null) {
          final String userId = user.uid;
          final String imageName = 'profile_$userId.jpg';
          final Reference reference =
              _storage.ref().child('profile_images').child(imageName);
          final UploadTask uploadImage =
              reference.putFile(File(pickedImage.path));
          final TaskSnapshot downloadUrl = (await uploadImage);
          final String url = await downloadUrl.ref.getDownloadURL();

          await _firestore.collection('user').doc(userId).update({
            'profile_image': url,
          });
        }
      }
    } catch (e) {
      print('Error uploading profile image: $e');
    }
  }
}
