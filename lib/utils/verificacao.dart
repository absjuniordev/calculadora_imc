String verificacao(double result) {
  if (result < 16) {
    return "Estado de Magreza grave\nIMC = ${result.ceil()}";
  } else if (result >= 16 && result < 17) {
    return "Estado de Magreza moderada\nIMC = ${result.ceil()}";
  } else if (result >= 17 && result < 18.5) {
    return "Estado de Magreza leve\nIMC = ${result.ceil()}";
  } else if (result >= 18.5 && result < 25) {
    return "Estado Saudavel\nIMC = ${result.ceil()}";
  } else if (result >= 25 && result < 30) {
    return "Estado de Sobrepeso\nIMC = ${result.ceil()}";
  } else if (result >= 30 && result < 35) {
    return "Estado Obesidade grau I\nIMC = ${result.ceil()}";
  } else if (result >= 35 && result < 40) {
    return "Estado Obesidade grau II (Severa)\nIMC = ${result.ceil()}";
  } else if (result >= 40) {
    return "Estado Obesidade grau III (mórbida)\nIMC = ${result.ceil()}";
  }
  return "Dados invalidos";
}
