import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/modules/splash/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/logo.png", scale: 10),
          ),
          Text("Inventory App",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.primary
            ),
          )
        ],
      ),
    );
  }
}
