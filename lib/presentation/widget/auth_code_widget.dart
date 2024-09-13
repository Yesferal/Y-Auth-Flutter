/* Copyright © 2024 Yesferal Cueva. All rights reserved. */
import 'package:flutter/material.dart';

class AuthCodeScreen extends StatefulWidget {
  const AuthCodeScreen({super.key});

  @override
  State<AuthCodeScreen> createState() {
    return _AuthCodeScreenState();
  }
}

class _AuthCodeScreenState extends State<AuthCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Code')),
      body: Column(
        children: [
          const Text("Please enter your authentication code"),
          const Text("Code"),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Enabled'),
          ),
        ],
      ),
    );
  }
}
