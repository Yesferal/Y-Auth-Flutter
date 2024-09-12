/* Copyright © 2024 Yesferal Cueva. All rights reserved. */
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Passwordless')),
      body: Column(
        children: [Text("Enter the code")],
      ),
    );
  }
}
