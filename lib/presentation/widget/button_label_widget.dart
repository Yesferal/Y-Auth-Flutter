/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:flutter/material.dart';

Widget getLabelButton(bool loading) {
  if (loading) {
    return const Padding(padding: EdgeInsets.all(16), child: Text('Continue'));
  } else {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: CircularProgressIndicator(),
    );
  }
}
