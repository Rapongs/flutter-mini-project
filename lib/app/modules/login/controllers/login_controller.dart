import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/app/routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String username, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: username, password: password);
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Get.snackbar('Error', 'Username or Password is wrong');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'Username must be filled with email');
      } else if (username == '') {
        Get.snackbar('Error', 'Username must be filled');
      } else if (password == '') {
        Get.snackbar('Error', 'Password must be filled');
      }
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
