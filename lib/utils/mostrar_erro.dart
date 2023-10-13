import 'package:flutter/material.dart';

Future<dynamic> mostrarErro(
    {required String title,
    required String content,
    required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
