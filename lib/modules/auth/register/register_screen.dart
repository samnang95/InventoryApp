import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventoryapp/api/controllers/auth_controller.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController controller = Get.find();

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _pickAvatar() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.setAvatar(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.paddingL),
        child: Column(
          children: [
            SizedBox(height: AppSpacing.paddingXXL),
            SizedBox(height: AppSpacing.paddingXXL),
            _images(context),
            SizedBox(height: AppSpacing.paddingXXL),
            // _avatar(),
            // SizedBox(height: AppSpacing.paddingXXL),
            _form(),
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
            'Register',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Please create your new account!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.greyColor
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(){
    return Obx(() => GestureDetector(
      onTap: _pickAvatar,
      child: CircleAvatar(
        radius: 60,
        backgroundColor: AppColors.greyColor.withOpacity(0.3),
        backgroundImage: controller.avatarFile.value != null
            ? FileImage(controller.avatarFile.value!)
            : null,
        child: controller.avatarFile.value == null
            ? const Icon(Icons.add_a_photo, size: 40, color: Colors.white)
            : null,
      ),
    ));
  }

  Widget _form(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// Name
          TextFormField(
            controller: nameController,
            onChanged: (value) => controller.name.value = value,
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: (value) => (value == null || value.isEmpty) ? "Enter name" : null,
          ),
          SizedBox(height: AppSpacing.paddingS),

          /// Email
          TextFormField(
            controller: emailController,
            onChanged: (value) => controller.email.value = value,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) => (value == null || value.isEmpty) ? "Enter email" : null,
          ),
          SizedBox(height: AppSpacing.paddingS),

          /// Password
          TextFormField(
            controller: passwordController,
            onChanged: (value) => controller.password.value = value,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (value) => (value == null || value.length < 6) ? "Password min 6" : null,
          ),
          SizedBox(height: AppSpacing.paddingXXL),

          /// Register Button
          SizedBox(
            width: double.infinity,
            child: Obx(() => ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.register();
                }
              },
              child: controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Register'),
            )),
          ),
        ],
      ),
    );
  }
}