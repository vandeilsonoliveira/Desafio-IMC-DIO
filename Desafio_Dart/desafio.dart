import 'dart:convert';
import 'dart:io';

class Pessoa {
  String nome = "";
  double peso = 0;
  double altura = 0;
}

void main(List<String> args) {
  Pessoa p = Pessoa();

  String testeIMC = "";
  do {
    try {
      p.nome = validarEntradaNome(lerConsoleString("Informe seu nome:"));
      p.peso = validarEntradaPesoAltura(lerConsoleString("Informe seu peso:"));
      p.altura =
          validarEntradaPesoAltura(lerConsoleString("Informe sua altura:"));

      String imc = calcularIMC(p.peso, p.altura);

      print("Sr(a): ${p.nome}, seu teste informa que está com $imc");

      testeIMC =
          lerConsoleString("Digite 'S' para reiniciar ou 'N' para finalizar");
    } catch (ex) {
      print("-------------------------------------------");
      print(ex);
      print("-------------------------------------------");
    }
  } while (testeIMC.toUpperCase() != "N");
}

String calcularIMC(double peso, double altura) {
  String nivel;
  double imc = peso / (altura * 2);

  switch (imc) {
    case < 16:
      nivel = "Magreza grave (${imc.toStringAsFixed(1)})";
      break;
    case (>= 16 && < 17):
      nivel = "Magreza moderada (${imc.toStringAsFixed(1)})";
      break;
    case (>= 17 && < 18.5):
      nivel = "Magreza leve (${imc.toStringAsFixed(1)})";
      break;
    case (>= 18.5 && < 25):
      nivel = "Peso saudável (${imc.toStringAsFixed(1)})";
      break;
    case (>= 25 && < 30):
      nivel = "Sobrepeso (${imc.toStringAsFixed(1)})";
      break;
    case (>= 30 && < 35):
      nivel = "Obesidade Grau I (${imc.toStringAsFixed(1)})";
      break;
    case (>= 35 && < 40):
      nivel = "Obesidade Grau II (severa) (${imc.toStringAsFixed(1)})";
      break;
    case (>= 40):
      nivel = "Obesidade Grau III (${imc.toStringAsFixed(1)})";
      break;
    default:
      nivel = "Indice de Massa Corporal inconsistente (${imc.toStringAsFixed(1)})";
      break;
  }

  return nivel;
}

String lerConsoleString(String titulo) {
  print(titulo);
  return stdin.readLineSync(encoding: utf8) ?? "";
}

String validarEntradaNome(String nome) {
  if(nome.isEmpty){
    throw ArgumentError("Preenchimento do nome obrigatório!");
  }

  if (nome.contains(RegExp(r'[0-9]'))) {
    throw ArgumentError("O nome não pode conter números!");
  }

  return nome;
}

double validarEntradaPesoAltura(String valor) {
  if(valor.isEmpty){
    throw ArgumentError("Preenchimento do pes/altura obrigatório!");
  }

  if (valor.toUpperCase().contains(RegExp(r'[A-Z]'))) {
    throw ArgumentError("valor informado inválido!");
  }

  return double.parse(valor.replaceAll(',', '.'));
}
