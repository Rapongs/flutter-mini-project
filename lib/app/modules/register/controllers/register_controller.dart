import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late TextEditingController usernameController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController confirmPassController = TextEditingController();

  void register(String username, String password, String confPassword) async {
    try {
      if (password == confPassword) {
        await auth.createUserWithEmailAndPassword(
            email: username, password: password);
      } else {
        Get.snackbar('Error', 'Wrong confirmation password');
      }

      usernameController.clear();
      passwordController.clear();
      confirmPassController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'Username must be fill with email');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'Username already registered');
      } else if (username == '') {
        Get.snackbar('Error', 'Username must be fill');
      } else if (password == '' && password.length < 8) {
        Get.snackbar(
            'Error', 'Password must be fill and greater than 8 character');
      }
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void addBiodata(
      String username, String name, String address, String phone) async {
    try {
      await firestore.collection('user').add({
        'username': username,
        'name': name,
        'address': address,
        'phone': phone,
      });

      Get.snackbar('Success', 'Success created account');
      Get.offNamed(Routes.LOGIN);

      nameController.clear();
      addressController.clear();
      phoneController.clear();
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void onInit() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPassController = TextEditingController();
    nameController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
