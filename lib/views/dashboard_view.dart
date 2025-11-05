import 'package:flutter/material.dart';
import '../core/layout/responsive_scaffold.dart';
import '../data/local_storage.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String email = '';
  String role = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final e = await LocalStorage.getUserEmail();
    final r = await LocalStorage.getUserRole();
    setState(() {
      email = e ?? '';
      role = r ?? '';
    });
  }

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/inventory');
    } else if (index == 0) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil en desarrollo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Panel principal',
      currentIndex: _currentIndex,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido $email', style: const TextStyle(fontSize: 22)),
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
    );
  }
}
