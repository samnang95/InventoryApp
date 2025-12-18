import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/user_controller.dart';
import 'package:inventoryapp/api/models/user_model.dart';
import 'package:inventoryapp/app/helper/image_picker_helper.dart';

class UserFormBottomSheet extends StatefulWidget {
  final User? user;

  const UserFormBottomSheet({Key? key, this.user}) : super(key: key);

  static void open({User? user}) {
    Get.bottomSheet(
      UserFormBottomSheet(user: user),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  @override
  State<UserFormBottomSheet> createState() => _UserFormBottomSheetState();
}

class _UserFormBottomSheetState extends State<UserFormBottomSheet> {
  final UserController controller = Get.find<UserController>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String role = "Staff"; // default
  File? avatarFile;

  // Error messages
  String? nameError;
  String? emailError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      role = widget.user!.role?.toLowerCase() == 'admin' ? 'Admin' : 'Staff';
    }
  }

  Future<void> pickAvatar() async {
    final file = await ImagePickerHelper.pickImageFromGallery();
    if (file != null) {
      setState(() {
        avatarFile = file;
      });
    }
  }

  Future<void> submit() async {
    setState(() {
      nameError = _nameController.text.trim().isEmpty ? "Name required" : null;
      emailError = _emailController.text.trim().isEmpty ? "Email required" : null;
      passwordError = (widget.user == null && _passwordController.text.trim().isEmpty)
          ? "Password required"
          : null;
    });

    if (nameError != null || emailError != null || passwordError != null) {
      return;
    }

    final normalizedRole = role.toLowerCase();

    if (widget.user == null) {
      // Create
      await controller.addUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: normalizedRole,
        avatarFile: avatarFile, // use File
      );
    } else {
      // Update
      await controller.editUser(
        id: widget.user!.id,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        passwordHash: _passwordController.text.trim().isEmpty
            ? null
            : _passwordController.text.trim(),
        role: normalizedRole,
        avatar: avatarFile, // use File
      );
    }

    Get.back(); // close bottomsheet
  }

  ImageProvider? getAvatarImage() {
    /// 1. Local file
    if (avatarFile != null) return FileImage(avatarFile!);

    /// 2. Network URL
    if (widget.user?.avatar != null && widget.user!.avatar.startsWith('http')) {
      return NetworkImage(widget.user!.avatar);
    }

    /// 3. Default: null
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user == null ? "Create User" : "Update User",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: pickAvatar,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: getAvatarImage(),
                  child: getAvatarImage() == null
                      ? const Icon(Icons.camera_alt, size: 32)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      errorText: nameError,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      errorText: emailError,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Password
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: widget.user == null ? "Password" : "New Password",
                      errorText: passwordError,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  // Role Dropdown
                  DropdownButtonFormField<String>(
                    value: role,
                    items: const [
                      DropdownMenuItem(value: "Admin", child: Text("Admin")),
                      DropdownMenuItem(value: "Staff", child: Text("Staff")),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => role = val);
                    },
                    decoration: const InputDecoration(labelText: "Role"),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: submit,
                      child: Text(widget.user == null ? "Create" : "Update"),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}