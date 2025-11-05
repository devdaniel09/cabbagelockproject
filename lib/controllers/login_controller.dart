import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../data/local_storage.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnack(context, 'Por favor, llena todos los campos.');
      return;
    }

    final result = await AuthService.login(email, password);
    if (result != null) {
      await LocalStorage.saveUserEmail(result['email']);
      await LocalStorage.saveUserRole(result['role']);
      if (result['role'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/inventory');
      } else {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } else {
      _showSnack(context, 'Credenciales incorrectas.');
    }
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
