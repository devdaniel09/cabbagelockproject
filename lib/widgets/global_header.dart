import 'package:flutter/material.dart';
import '../data/local_storage.dart';

class GlobalHeaderActions extends StatelessWidget {
  const GlobalHeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocalStorage.getUserEmail(),
      builder: (context, snapshot) {
        final email = snapshot.data ?? '';
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No hay notificaciones nuevas'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            if (email != '')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  email.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            const SizedBox(width: 8),
          ],
        );
      },
    );
  }
}
