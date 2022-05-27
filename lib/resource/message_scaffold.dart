import 'package:flutter/material.dart';

class MessageScaffold {
  Scaffold(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '${message}',
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    ));
  }
}
