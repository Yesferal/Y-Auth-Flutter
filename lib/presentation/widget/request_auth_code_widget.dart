/* Copyright © 2024 Yesferal Cueva. All rights reserved. */
import 'package:flutter/material.dart';
import 'package:y_auth/domain/abstract/auth_environment.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';
import 'package:y_auth/domain/usecase/request_auth_code_usecase.dart';
import 'package:y_auth/framework/http/auth_http_datasource.dart';
import 'package:y_auth/framework/validator/auth_email_validator_third_party.dart';
import 'package:y_auth/presentation/widget/request_auth_token_widget.dart';

class RequestAuthCodeScreen extends StatefulWidget {
  final AuthEnvironment authEnvironment;
  final String appColor;
  final String appName;
  final String appPackageName;
  final String deviceId;

  const RequestAuthCodeScreen(this.authEnvironment, this.appColor, this.appName, this.appPackageName, this.deviceId, {super.key});

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
              onPressed: () async {
                var emailInput = _myController.text;
                var response = await RequestAuthCodeUseCase(AuthEmailValidatorImpl(), HttpDataSource(widget.authEnvironment)).execute(widget.appColor, widget.appName, emailInput);

                switch (response) {
                  case ErrorResponse():
                    debugPrint("Error message: ${response.message}");
                    setState(() {
                      _errorMessage = response.displayMessage;
                    });
                    break;
                  case SuccessResponse():
                    debugPrint("Success message: ${response.data}");
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestAuthTokenScreen(widget.authEnvironment, widget.appPackageName, widget.deviceId, emailInput)),
                      );
                    }
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
