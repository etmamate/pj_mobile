import 'package:flutter/material.dart';
import 'package:pj_mobile/pages/tela_review.dart';

class Telalogin extends StatelessWidget {
  const Telalogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      theme: ThemeData.dark(), // Tema escuro para imitar o fundo da imagem
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    paraHome() {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TelaReview()));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou título do app
            Text(
              'Senhor dos Reviews',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal[100],
              ),
            ),
            SizedBox(height: 20),
            // Texto de boas-vindas
            Text(
              'Bem-vindo de volta!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Realize o login abaixo para acessar sua conta.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            // Campo de e-mail
            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                hintText: 'Digite seu e-mail...',
              ),
            ),
            SizedBox(height: 10),
            // Campo de senha
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                hintText: 'Digite sua senha...',
              ),
            ),
            SizedBox(height: 10),
            // Link "Forgot Password?"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text('Esqueci minha senha?'),
              ),
            ),
            SizedBox(height: 10),
            // Botão Login
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                iconColor: const Color.fromARGB(255, 0, 150, 136), // Cor do botão na imagem
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Login', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 10),
            // Link "Don't have an account? Create"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Não tem uma conta? "),
                TextButton(onPressed: () {}, child: Text('Criar')),
              ],
            ),
            SizedBox(height: 10),
            // Botão Continue as Guest
            OutlinedButton(
              onPressed: paraHome,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                side: BorderSide(color: Colors.teal),
              ),
              child: Text(
                'Continuar como convidado',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            // Linha curva inferior (simplificada)
            // Container(
            //   height: 50,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Colors.teal, Colors.black],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
