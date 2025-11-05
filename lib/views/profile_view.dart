import 'package:flutter/material.dart';
import '../core/layout/responsive_scaffold.dart';
import '../data/local_storage.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String email = '';
  String role = '';
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final e = await LocalStorage.getUserEmail();
    final r = await LocalStorage.getUserRole();
    setState(() {
      email = e ?? '';
      role = r ?? '';
    });
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/inventory');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Perfil del Usuario',
      currentIndex: _currentIndex,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person, size: 80, color: Colors.green),
                  const SizedBox(height: 16),
                  Text(
                    email.isNotEmpty ? email : 'Usuario desconocido',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Rol: $role', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await LocalStorage.clear();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Cerrar sesión'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
