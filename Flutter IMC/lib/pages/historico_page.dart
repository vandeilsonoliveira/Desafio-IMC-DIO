import 'package:desafio_imc/model/imc.dart';
import 'package:desafio_imc/repositories/imc_repository.dart';
import 'package:flutter/material.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  final _repo = ImcRepository();

  List<IMC> imcs = [];

  void obterHistorico() async {
    imcs = await _repo.listar();
    setState(() {});
  }

  @override
  void initState() {
    obterHistorico();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: imcs.length,
        itemBuilder: (ctx, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text('Altura: ${imcs[index].altura} * Peso: ${imcs[index].peso}')),
                    Text(imcs[index].dataRegistro),
                  ],
                ),

                Text('Resultado: ${imcs[index].resultado}'),

                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
