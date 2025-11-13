import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          // Header Section
          Container(
            color: Colors.lightBlue,
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),

                      // back to setting
                      onPressed: () {
                        Get.back();
                      },
                    ),

                    const Spacer(),
                    const Text(
                      "Profile Screen",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('assets/images/s1.jpg'),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.camera_alt, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          // Card Section
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: const Offset(0, -40), // move card up safely
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildListTile(
                            title: "Name",
                            subtitle: controller.name.value,
                            onTap: () {},
                          ),
                          buildDivider(),
                          buildListTile(
                            title: "Signed in with",
                            subtitle: controller.signInMethod.value,
                            onTap: () {},
                          ),
                          buildDivider(),
                          buildListTile(
                            title: "Language",
                            subtitle: controller.language.value,
                            onTap: () {},
                          ),
                          buildDivider(),
                          buildListTile(
                            title: "Delete Data",
                            subtitle: "",
                            onTap: () {
                              Get.snackbar("Delete", "Delete data clicked");
                            },
                          ),
                          buildDivider(),
                          buildListTile(
                            title: "Sign Out",
                            subtitle: "",
                            textColor: Colors.red,
                            onTap: () {
                              Get.snackbar("Sign Out", "You have signed out");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile({
    required String title,
    required String subtitle,
    Color textColor = Colors.black,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title, style: TextStyle(color: textColor, fontSize: 16)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (subtitle.isNotEmpty)
            Text(subtitle, style: const TextStyle(fontSize: 16)),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget buildDivider() => const Divider(height: 1);
}
