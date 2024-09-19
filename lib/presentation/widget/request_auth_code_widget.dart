/* Copyright © 2024 Yesferal Cueva. All rights reserved. */
import 'package:flutter/material.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';
import 'package:y_auth/domain/usecase/request_auth_code_usecase.dart';
import 'package:y_auth/domain/usecase/validate_email_usecase.dart';
import 'package:y_auth/presentation/widget/request_auth_token_widget.dart';

class RequestAuthCodeScreen extends StatefulWidget {
  const RequestAuthCodeScreen({super.key});

  @override
  State<RequestAuthCodeScreen> createState() {
    return _RequestAuthCodeScreenState();
  }
}

class _RequestAuthCodeScreenState extends State<RequestAuthCodeScreen> {

  final _myController = TextEditingController();

  String? _errorMessage;

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
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Email',
                errorText: _errorMessage,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                var response = RequestAuthCodeUseCase(ValidateEmailUseCase()).execute(_myController.text);

                switch (response) {
                  case ErrorResponse():
                    debugPrint("Error message: ${response.message}");
                    setState(() {
                      _errorMessage = response.message;
                    });
                    break;
                  case SuccessResponse():
                    debugPrint("Success message: ${response.data}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RequestAuthTokenScreen()),
                    );
                    setState(() {
                      _errorMessage = null;
                    });
                    break;
                }
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
