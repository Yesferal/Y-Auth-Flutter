/* Copyright © 2024 Yesferal Cueva. All rights reserved. */
import 'dart:async';
import 'package:flutter/material.dart';

class AuthCodeScreen extends StatefulWidget {
  const AuthCodeScreen({super.key});

  @override
  State<AuthCodeScreen> createState() {
    return _AuthCodeScreenState();
  }
}

class _AuthCodeScreenState extends State<AuthCodeScreen> {
  late Timer _timer;

  final _interval = const Duration(seconds: 1);

  final int _timerMaxSeconds = 60;

  int _currentSeconds = 0;

  @override
  void initState() {
    _startTimeout();
    super.initState();
  }

  @override
  void dispose() {
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
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Code',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
                // TODO: Fix this. Use Route with Name instead
                //Navigator.popUntil(context, ModalRoute.withName('/Home'));
              },
              child: const Text('Continue'),
            ),
            Padding(
                padding: EdgeInsets.all(24),
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
