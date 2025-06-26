import 'package:flutter/material.dart';
import 'package:pj_mobile/pages/tela_review.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<StatefulWidget> createState() => _TelaPrincipal();
}

class _TelaPrincipal extends State<TelaPrincipal> {
  paraHome() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => TelaReview()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => paraHome(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 150, 136),
              ),
              child: Text('Cadastrar Review', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
