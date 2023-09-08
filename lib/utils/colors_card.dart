import 'package:flutter/material.dart';

Color determinarCor(double valor) {
  if (valor <= 18.5) {
    return Colors.yellow;
  } else if (valor > 18.5 && valor <= 24.9) {
    return const Color.fromARGB(255, 11, 119, 14);
  } else if (valor > 24.9 && valor <= 29.9) {
    return const Color.fromARGB(255, 211, 182, 145);
  } else if (valor > 30 && valor <= 34.9) {
    return const Color.fromARGB(255, 196, 123, 14);
  } else if (valor > 35 && valor <= 39.9) {
    return const Color.fromARGB(255, 231, 43, 43);
  } else {
    return const Color.fromARGB(255, 212, 11, 11);
  }
}
