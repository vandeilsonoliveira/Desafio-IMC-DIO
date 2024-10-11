import 'package:meu_app/Desafio_Dart/desafio.dart' as imc;
import 'package:test/test.dart';

void main() {
  test('Validar valor de entrada para o nome', () {
    expect(imc.validarEntradaNome("valor"), equals("valor"));
  });

  test('Validar valor de entrada para o nome (throw)', () {
    expect(
        () => imc.validarEntradaNome("valor1"), throwsA(TypeMatcher<ArgumentError>()));
  });

  //-
  test('Validar valor de entrada para peso/altura', () {
    expect(imc.validarEntradaPesoAltura("85"), equals(85));
  });

  test('Validar valor de entrada para peso/altura (error)', () {
    expect(imc.validarEntradaPesoAltura("1.81"), equals(1.50));
  });

  test('Validar valor de entrada para peso/altura (throw)', () {
    expect(
        () => imc.validarEntradaPesoAltura("70a"), throwsA(TypeMatcher<ArgumentError>()));
  });

  test('Calculo do IMC', () {
    expect(imc.calcularIMC(55, 1.71), equals("Magreza moderada"));
  });
}
