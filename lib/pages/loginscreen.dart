import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      theme: ThemeData.dark(), // Tema escuro para imitar o fundo da imagem
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou título do app
            Text(
              'Senhor dos Review',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal[100],
              ),
            ),
            SizedBox(height: 20),
            // Texto de boas-vindas
            Text(
              'Welcome back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Login to access your account below.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            // Campo de e-mail
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                hintText: 'Enter your email...',
              ),
            ),
            SizedBox(height: 10),
            // Campo de senha
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                hintText: 'Enter your password...',
              ),
            ),
            SizedBox(height: 10),
            // Link "Forgot Password?"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text('Forgot Password?'),
              ),
            ),
            SizedBox(height: 10),
            // Botão Login
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                iconColor: Colors.teal, // Cor do botão na imagem
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Login', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 10),
            // Link "Don't have an account? Create"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                TextButton(onPressed: () {}, child: Text('Create')),
              ],
            ),
            SizedBox(height: 10),
            // Botão Continue as Guest
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                side: BorderSide(color: Colors.teal),
              ),
              child: Text(
                'Continue as Guest',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            // Linha curva inferior (simplificada)
            Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
