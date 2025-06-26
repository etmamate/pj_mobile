import 'package:flutter/material.dart';
import 'package:pj_mobile/pages/tela_detalhes_serie.dart';
import 'package:pj_mobile/pages/tela_review.dart';
import 'package:pj_mobile/pages/telalogin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://bfhyzveodjyeqfusbyio.supabase.co';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJmaHl6dmVvZGp5ZXFmdXNieWlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA4MDc2MjcsImV4cCI6MjA2NjM4MzYyN30.uZV8OnzvC-MTjVi9IkSBwg-sr_N8ZC1QSlCmzhdWa6I',
  );
  runApp(Telalogin());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Mobile',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/review': (context) => TelaReview(),
        '/detalhes':
            (context) => TelaDetalhesSerie(
              tvShowId: ModalRoute.of(context)!.settings.arguments as int,
            ),
      },
    );
  }
}
