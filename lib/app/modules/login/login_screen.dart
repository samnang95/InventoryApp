import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/login/login_controller.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: ListView(
            children: [
              const SizedBox(height: 60),
              _images(),
              const SizedBox(height: 20),
              _title(),
              const SizedBox(height: 40),
              _subtitle(),
              const SizedBox(height: 20),

              // ✅ Form with validators
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _emailForm(),
                    const SizedBox(height: 20),
                    _passwordForm(),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              _buttonLogin(),
              const SizedBox(height: 20),
              _signup(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _images() {
    return Image.asset(
      'assets/images/box1.jpg',
      width: 200,
      height: 200,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.inventory_2, size: 100, color: Colors.grey[600]),
        );
      },
    );
  }

  Widget _title() {
    return const Text(
      'InventoryApp',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Color(0xFF00B4D8),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _subtitle() {
    return const Text(
      'Please login to your account',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  // ✅ Email Form Field
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

  // ✅ Password Form Field with Validator
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

  // ✅ Button checks the form validation
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

  Widget _signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.register),
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
