import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';
import '../state/auth_state.dart';

class ProfilePage extends StatelessWidget {
  final AuthState authState;

  const ProfilePage({super.key, required this.authState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 40,
            child: Icon(Icons.person, size: 40),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              authState.username,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('Nama pengguna'),
            subtitle: Text(authState.username),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              authState.logout();
              context.go(AppRoutes.login);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
