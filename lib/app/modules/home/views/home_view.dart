import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('lib/assets/images/bg-home.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
              child: Column(
                children: [
                  Obx(() {
                    final userData = controller.userData.value;
                    final String name = userData['name'] ?? '';
                    final String address = userData['address'] ?? '';
                    final String phoneNumber = userData['phone'] ?? '';
                    final String profileImageUrl =
                        userData['profile_image'] ?? '';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, $name',
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "How's your day going?",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: profileImageUrl.isNotEmpty
                                  ? NetworkImage(profileImageUrl)
                                  : const AssetImage(
                                          'lib/assets/images/default_profile.png')
                                      as ImageProvider,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'My Address: $address',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'My Phone Number: $phoneNumber',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                controller.uploadProfileImage();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.purple[200],
                                fixedSize: const Size(290, 50),
                              ),
                              child: const Text(
                                'Upload Foto',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        )
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
