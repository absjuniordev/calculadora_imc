import 'package:flutter/material.dart';

AppBar getHomeAppBar(String text) {
  return AppBar(
    toolbarHeight: 100,
    centerTitle: true,
    title: Column(children: [
      const Text("Calculo IMC"),
      Text(text),
    ]),
  );
}
