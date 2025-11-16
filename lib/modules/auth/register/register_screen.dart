import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/modules/auth/register/register_controller.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _images(context),
              SizedBox(height: AppSpacing.paddingXXL),
              _form(),
              SizedBox(height: AppSpacing.paddingXXL),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade900,
                  ),
                  onPressed: () {
                    Get.offNamed(AppRoutes.login);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _images(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            scale: 10,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.inventory_2,
                  size: 100,
                  color: Colors.grey[600],
                ),
              );
            },
          ),
          Text(
            'Sign Up',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Please sign up to access your account!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.greyColor
            ),
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _form() {
    return Column(
      children: [
        TextField(
          onChanged: (v) => controller.email.value = v,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
        SizedBox(height: AppSpacing.paddingS),
        Obx(() => TextField(
          onChanged: (v) => controller.password.value = v,
          obscureText: !controller.showPassword.value,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                controller.showPassword.value ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: controller.togglePassword,
            ),
          ),
        )),
        SizedBox(height: AppSpacing.paddingS),
        Obx(() => TextField(
          onChanged: (v) => controller.confirmPassword.value = v,
          obscureText: !controller.showConfirmPassword.value,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                controller.showConfirmPassword.value ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: controller.toggleConfirmPassword,
            ),
          ),
        )),
      ],
    );
  }

}