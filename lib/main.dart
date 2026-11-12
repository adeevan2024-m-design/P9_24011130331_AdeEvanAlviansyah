import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router/app_router.dart';
import 'state/auth_state.dart';
import 'state/cart_state.dart';
import 'theme/app_colors.dart';

void main() {
 
  final authState = AuthState();
  final cartState = CartState();
  final router = createRouter(authState, cartState);
  runApp(TokoApp(router: router));
}

class TokoApp extends StatelessWidget {
  const TokoApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Toko App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.surface,
      ),
      routerConfig: router,
    );
  }
}
