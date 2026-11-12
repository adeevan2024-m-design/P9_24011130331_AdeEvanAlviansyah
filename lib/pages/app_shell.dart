import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/cart_state.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final CartState cartState;

  const AppShell({
    super.key,
    required this.navigationShell,
    required this.cartState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ListenableBuilder(
        listenable: cartState,
        builder: (context, _) {
          return NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              const NavigationDestination(
                icon: Icon(Icons.search),
                label: 'Cari',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text('${cartState.count}'),
                  isLabelVisible: cartState.count > 0,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                selectedIcon: Badge(
                  label: Text('${cartState.count}'),
                  isLabelVisible: cartState.count > 0,
                  child: const Icon(Icons.shopping_cart),
                ),
                label: 'Keranjang',
              ),
              const NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          );
        },
      ),
    );
  }
}
