/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:y_auth/domain/abstract/auth_environment.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';
import 'package:y_auth/domain/model/token_model.dart';
import 'package:y_auth/domain/usecase/request_auth_code_usecase.dart';
import 'package:y_auth/framework/http/auth_http_datasource.dart';
import 'package:y_auth/framework/logger/y_log.dart';
import 'package:y_auth/framework/validator/auth_email_validator_third_party.dart';
import 'package:y_auth/presentation/widget/button_label_widget.dart';
import 'package:y_auth/presentation/widget/request_auth_token_widget.dart';

class RequestAuthCodeScreen extends StatefulWidget {
  final AuthEnvironment authEnvironment;
  final String appColor;
  final String appName;
  final String appPackageName;

  const RequestAuthCodeScreen(
      this.authEnvironment, this.appColor, this.appName, this.appPackageName,
      {super.key});

  @override
  State<RequestAuthCodeScreen> createState() {
    return _RequestAuthCodeScreenState();
  }
}

class _RequestAuthCodeScreenState extends State<RequestAuthCodeScreen> {
  final _myController = TextEditingController();

  String? _errorMessage;

  bool _isButtonEnabled = true;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
                "We'll check if you have an account and help create one if you don't."),
            const SizedBox(height: 24),
            const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
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
                onPressed: _isButtonEnabled
                    ? () async {
                        setState(() {
                          _isButtonEnabled = false;
                        });
                        var emailInput = _myController.text;
                        var response = await RequestAuthCodeUseCase(
                                AuthEmailValidatorImpl(),
                                HttpDataSource(widget.authEnvironment))
                            .execute(
                                widget.appColor, widget.appName, emailInput);

                        switch (response) {
                          case ErrorResponse():
                            YLog.d("Error message: ${response.message}");
                            setState(() {
                              _isButtonEnabled = true;
                              _errorMessage = response.displayMessage;
                            });
                            break;
                          case SuccessResponse():
                            try {
                              ApiResponseModel apiResponseModel =
                                  ApiResponseModel.fromJson(
                                      json.decode(response.body));
                              if (context.mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RequestAuthTokenScreen(
                                                widget.authEnvironment,
                                                widget.appPackageName,
                                                widget.appColor,
                                                widget.appName,
                                                emailInput,
                                                apiResponseModel.messages?.displayMessage ??
                                                    "Once you enter the code we sent to your email, you'll be all toggled in")));
                              }
                            } catch (e) {
                              YLog.d("Error message: ${e}");
                            }
                            setState(() {
                              _isButtonEnabled = true;
                              _errorMessage = null;
                            });
                            break;
                        }
                      }
                    : null,
                child: getLabelButton(_isButtonEnabled)),
          ],
        ),
      ),
    );
  }
}
