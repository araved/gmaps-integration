import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String error;
  Error(this.error);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(error),
      actions: [
        FlatButton(
            onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
      ],
    );
  }
}
