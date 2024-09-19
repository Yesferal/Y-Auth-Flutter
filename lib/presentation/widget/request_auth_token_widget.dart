/* Copyright © 2024 Yesferal Cueva. All rights reserved. */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';
import 'package:y_auth/domain/usecase/request_token_usecase.dart';

class RequestAuthTokenScreen extends StatefulWidget {
  const RequestAuthTokenScreen({super.key});

  @override
  State<RequestAuthTokenScreen> createState() {
    return _RequestAuthTokenScreenScreenState();
  }
}

class _RequestAuthTokenScreenScreenState extends State<RequestAuthTokenScreen> {
  late Timer _timer;

  final _interval = const Duration(seconds: 1);

  final int _timerMaxSeconds = 60;

  int _currentSeconds = 0;

  final _myController = TextEditingController();

  String? _errorMessage;

  @override
  void initState() {
    _startTimeout();
    super.initState();
  }

  @override
  void dispose() {
    _myController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var resentCodeWidget = (_currentSeconds >= _timerMaxSeconds)
        ? TextButton(
            onPressed: () {
              _startTimeout();
            },
            child: const Text("Resend a code"),
          )
        : TextButton(
            onPressed: null,
            child: Text(
                "Resent in ${_timerMaxSeconds - _currentSeconds} seconds"));

    return Scaffold(
      appBar: AppBar(title: const Text('Finish logging in')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
                "Once you enter the code we sent to your email, you'll be all toggled in"),
            const SizedBox(height: 24),
            TextField(
              controller: _myController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Code',
                errorText: _errorMessage,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                var response = await RequestTokenUseCase().execute(_myController.text);

                switch (response) {
                  case ErrorResponse():
                    debugPrint("Error message: ${response.message}");
                    setState(() {
                      _errorMessage = response.message;
                    });
                    break;

                  case SuccessResponse():
                    debugPrint("Success message: ${response.data}");
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                    // TODO: Fix this. Use Route with Name instead
                    //Navigator.popUntil(context, ModalRoute.withName('/Home'));

                    setState(() {
                      _errorMessage = null;
                    });
                    break;
                }
              },
              child: const Text('Continue'),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Didn't get the code?"),
                    resentCodeWidget
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _startTimeout() {
    _timer = Timer.periodic(_interval, (timer) {
      setState(() {
        debugPrint("Tick time: ${timer.tick}");
        _currentSeconds = timer.tick;
        if (timer.tick >= _timerMaxSeconds) {
          timer.cancel();
        }
      });
    });
  }
}
