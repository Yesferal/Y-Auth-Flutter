/* Copyright © 2024 Yesferal Cueva. All rights reserved. */
import 'package:flutter/material.dart';
import 'package:y_auth/presentation/widget/auth_code_widget.dart';

class PasswordlessScreen extends StatefulWidget {
  const PasswordlessScreen({super.key});

  @override
  State<PasswordlessScreen> createState() {
    return _PasswordlessScreenState();
  }
}

class _PasswordlessScreenState extends State<PasswordlessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Continue with email')),
      body: Column(
        children: [
          const Text("We'll check if you have an account and help create one if you don't."),
          const Text("Email"),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AuthCodeScreen()),
              );
            },
            child: const Text('Enabled'),
          ),
        ],
      ),
    );
  }
}
