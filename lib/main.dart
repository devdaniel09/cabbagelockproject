import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/app_routes.dart';

void main() {
  runApp(const CabbageLockApp());
}

class CabbageLockApp extends StatelessWidget {
  const CabbageLockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CabbageLock',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
