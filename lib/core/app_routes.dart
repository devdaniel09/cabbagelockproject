import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../views/dashboard_view.dart';
import '../views/inventory_view.dart';
import '../views/profile_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String inventory = '/inventory';
  static const String profile = '/profile';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginView(),
    dashboard: (context) => const DashboardView(),
    inventory: (context) => const InventoryView(),
    profile: (context) => const ProfileView(),
  };
}
