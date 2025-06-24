import 'package:flutter/material.dart';

class Telahomepage extends StatelessWidget {
  const Telahomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Telahomepage(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
