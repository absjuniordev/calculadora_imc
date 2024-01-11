import 'package:flutter/material.dart';
import '../repository/sqlite/sqlite_repository.dart';

Future<dynamic> customShowDialog({
  required bool delete,
  required String title,
  required String content,
  required BuildContext context,
  SQLiteRepository? dadosIMCRepository,
  int? id,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        id != null
            ? TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(false);
                  if (delete) {
                    await dadosIMCRepository?.removerIMC(id);
                  }
                },
                child: const Text('Sim'),
              )
            : Container(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: id != null ? const Text('Não') : const Text('Ok'),
        ),
      ],
    ),
  );
}
