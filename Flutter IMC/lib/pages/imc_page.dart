import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:desafio_imc/model/imc.dart';
import 'package:desafio_imc/repositories/imc_repository.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final _repo = ImcRepository();

  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  void _calcularEExibirImc() async {
    double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));
    double? altura =
        double.tryParse(_alturaController.text.replaceAll(',', '.'));

    if (peso != null && altura != null && altura > 0) {
      double imc = peso / (altura * altura);
      String resultado = _nivelImc(imc);
      String dataRegistro =
          DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.now());

      IMC data = IMC(
        peso: peso,
        altura: altura,
        resultado: resultado,
        dataRegistro: dataRegistro,
      );
      await _repo.adicionar(data);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Resultado do IMC"),
            content: Text(resultado),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _pesoController.text = "";
                    _alturaController.text = "";
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Erro"),
            content: const Text(
                "Por favor, insira valores válidos para peso e altura."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  String _nivelImc(double imc) {
    switch (imc) {
      case < 16:
        return "Magreza grave (${imc.toStringAsFixed(1)})";
      case (>= 16 && < 17):
        return "Magreza moderada (${imc.toStringAsFixed(1)})";
      case (>= 17 && < 18.5):
        return "Magreza leve (${imc.toStringAsFixed(1)})";
      case (>= 18.5 && < 25):
        return "Peso saudável (${imc.toStringAsFixed(1)})";
      case (>= 25 && < 30):
        return "Sobrepeso (${imc.toStringAsFixed(1)})";
      case (>= 30 && < 35):
        return "Obesidade Grau I (${imc.toStringAsFixed(1)})";
      case (>= 35 && < 40):
        return "Obesidade Grau II (severa) (${imc.toStringAsFixed(1)})";
      case (>= 40):
        return "Obesidade Grau III (mórbida) (${imc.toStringAsFixed(1)})";
      default:
        return "Indice de Massa Corporal inconsistente (${imc.toStringAsFixed(1)})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //-
            const SizedBox(
              height: 50,
            ),

            //-
            SizedBox(
              height: 200,
              width: 200,
              child: Image.network(
                "https://cdn-icons-png.freepik.com/256/3663/3663924.png?semt=ais_hybrid",
              ),
            ),

            //-
            const SizedBox(
              height: 40,
            ),

            //-
            _buildTextField(
                _alturaController, Icons.height_rounded, "Informe sua altura"),

            //-
            _buildTextField(_pesoController, Icons.monitor_weight_rounded,
                "Informe seu peso"),

            //-
            _buidButtons(_calcularEExibirImc),
          ],
        ),
      ),
    );
  }

  Container _buildTextField(
      TextEditingController controller, IconData icon, String hint) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: 50,
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          debugPrint(value);
        },
        style: const TextStyle(color: Colors.black),
        keyboardType: const TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 141, 79, 151),
          ),
        ),
      ),
    );
  }

  Container _buidButtons(Function onPress) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      alignment: Alignment.center,
      height: 50,
      color: const Color.fromARGB(255, 55, 170, 45),
      child: TextButton(
        onPressed: () {
          onPress();
        },
        child: const Text(
          'Calcular',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
