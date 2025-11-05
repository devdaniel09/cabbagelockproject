// lib/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  /// Login de prueba: acepta cualquier email y contraseña.
  /// - Si el email contiene 'admin' (case-insensitive) -> role = 'admin'
  /// - En otro caso -> role = 'employee'
  /// Devuelve mapa { 'email': ..., 'role': ... } siempre (nunca null).
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    // Simula pequeña latencia
    await Future.delayed(const Duration(milliseconds: 300));

    final normalized = email.toLowerCase();
    final role = normalized.contains('admin') ? 'admin' : 'employee';

    // Guardamos en SharedPreferences para mantener la sesión (igual que antes)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
    await prefs.setString('userRole', role);

    return {'email': email, 'role': role};
  }
}
