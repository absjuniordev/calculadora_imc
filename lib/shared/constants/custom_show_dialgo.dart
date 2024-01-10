import 'package:flutter/material.dart';

customShowDialog(BuildContext context, String title, String content) {
  return showDialog(
    context: context,
    builder: (BuildContext bc) {
      return AlertDialog(
        title: const Text("Salvar"),
        content: const Text(
          "Deseja favoritar este Card?",
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Sim"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Não"),
          ),
        ],
      );
    },
  );
}
