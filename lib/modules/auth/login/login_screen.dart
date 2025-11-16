import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/constants/app_string.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/modules/auth/login/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _images(context),
            SizedBox(height: AppSpacing.paddingXXL),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _emailForm(),
                  SizedBox(height: AppSpacing.paddingS),
                  _passwordForm(),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.paddingXXL),
            _buttonLogin(),
            _signup(context),
          ],
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
            'Login',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Please login to access your account!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.greyColor
              // fontWeight: FontWeight.w600,
              // color: Theme.of(context).colorScheme.secondary,
            ),
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _emailForm() {
    return TextFormField(
      controller: emailController,
      onChanged: (value) => controller.email.value = value,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'your email here...',
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        } else if (!GetUtils.isEmail(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _passwordForm() {
    return TextFormField(
      controller: passwordController,
      onChanged: (value) => controller.password.value = value,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'your password here...',
        prefixIcon: const Icon(Icons.lock_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.login();
            } else {
              Get.snackbar(
                "Error",
                "Please fill all fields correctly",
                backgroundColor: Colors.red.shade600,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
          child: controller.isLoading.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
        ),
      ),
    );
  }

  Widget _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.register),
          child: Text(
            'Sign Up',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
