import 'package:desafio_imc/pages/imc_page.dart';
import 'package:flutter/material.dart';

import 'pages/historico_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: const [
                  ImcPage(),
                  HistoricoPage(),
                ],
              ),
            ),

            //-
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                controller.jumpToPage(value);
              },
              currentIndex: posicaoPagina,
              items: const [
                BottomNavigationBarItem(
                  label: "IMC",
                  icon: Icon(Icons.playlist_add_sharp),
                ),

                //-
                BottomNavigationBarItem(
                  label: "Histórico",
                  icon: Icon(Icons.history_rounded),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
