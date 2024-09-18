/* Copyright © 2024 Yesferal Cueva. All rights reserved. */
import 'package:flutter/material.dart';
import 'package:y_auth/domain/usecase/get_auth_code_usecase.dart';
import 'package:y_auth/presentation/widget/auth_code_widget.dart';

class PasswordlessScreen extends StatefulWidget {
  const PasswordlessScreen({super.key});

  @override
  State<PasswordlessScreen> createState() {
    return _PasswordlessScreenState();
  }
}

class _PasswordlessScreenState extends State<PasswordlessScreen> {

  final _myController = TextEditingController();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Continue with email')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
                "We'll check if you have an account and help create one if you don't."),
            const SizedBox(height: 24),
            TextField(
              controller: _myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                GetAuthCodeUseCase().execute(_myController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthCodeScreen()),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
