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
  final size = MediaQuery.of(context).size;
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: size.width * .035),
      ),
      content: Text(
        content,
        style: TextStyle(fontSize: size.width * .02),
      ),
      actions: <Widget>[
        id != null
            ? TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(false);
                  if (delete) {
                    await dadosIMCRepository?.removerIMC(id);
                  }
                },
                child: Text(
                  'Sim',
                  style: TextStyle(fontSize: size.width * .02),
                ),
              )
            : Container(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: id != null
              ? Text(
                  'Não',
                  style: TextStyle(fontSize: size.width * .02),
                )
              : Text(
                  'Ok',
                  style: TextStyle(fontSize: size.width * .02),
                ),
        ),
      ],
    ),
  );
}
