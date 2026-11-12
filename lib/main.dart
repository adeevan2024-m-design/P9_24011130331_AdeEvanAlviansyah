import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router/app_router.dart';
import 'state/auth_state.dart';
import 'state/cart_state.dart';

void main() {
  final authState = AuthState();
  final cartState = CartState();
  final router = createAppRouter(
    authState: authState,
    cartState: cartState,
  );
  runApp(
    TokoApp(
      authState: authState,
      cartState: cartState,
      router: router,
    ),
  );
}

class TokoApp extends StatelessWidget {
  final AuthState authState;
  final CartState cartState;
  final GoRouter router;

  const TokoApp({
    super.key,
    required this.authState,
    required this.cartState,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Toko App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
