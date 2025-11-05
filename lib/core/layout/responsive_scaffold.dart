import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';
import '../../widgets/global_header.dart';

class ResponsiveScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final int currentIndex;

  const ResponsiveScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/inventory');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveHelper.isDesktop(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    // MOBILE VIEW
    if (!isDesktop && !isTablet) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: const [GlobalHeaderActions()],
        ),
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) => _onItemTapped(context, i),
          selectedItemColor: Colors.green,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Panel'),
            BottomNavigationBarItem(
                icon: Icon(Icons.inventory), label: 'Inventario'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      );
    }

    // DESKTOP / TABLET VIEW
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: currentIndex,
            onDestinationSelected: (i) => _onItemTapped(context, i),
            labelType: NavigationRailLabelType.all,
            backgroundColor: Colors.grey.shade100,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Panel'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory_2_outlined),
                selectedIcon: Icon(Icons.inventory_2),
                label: Text('Inventario'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Perfil'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(title),
                actions: const [GlobalHeaderActions()],
              ),
              body: body,
            ),
          ),
        ],
      ),
    );
  }
}
