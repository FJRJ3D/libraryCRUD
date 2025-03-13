import 'package:flutter/material.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _register() async {
    var user = await _authService.registerUser(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registro exitoso")),
      );
    }
  }

  void _login() async {
    var user = await _authService.loginUser(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inicio de sesión exitoso")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: Text("Registrarse")),
            ElevatedButton(onPressed: _login, child: Text("Iniciar sesión")),
          ],
        ),
      ),
    );
  }
}
