import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: SafeArea(
        child: Column(
          children: [
            CircleAvatar(backgroundImage: AssetImage('assets/images/s6.jpg')),
          ],
        ),
      ),
    );
  }
}
