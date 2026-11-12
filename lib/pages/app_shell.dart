import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/cart_state.dart';
import '../theme/app_colors.dart';

/// `body` me [navigationShell].
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
    required this.cartState,
  });

  final StatefulNavigationShell navigationShell;
  final CartState cartState;

  void _onTabSelected(int index) {
    navigationShell.goBranch(
      index,
      
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ListenableBuilder(
        listenable: cartState, // badge ikut berubah saat keranjang berubah
        builder: (context, child) => NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTabSelected,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          indicatorColor: AppColors.primary.withAlpha(30),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
              label: 'Beranda',
            ),
            const NavigationDestination(
              icon: Icon(Icons.search_rounded),
              selectedIcon:
                  Icon(Icons.search_rounded, color: AppColors.primary),
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
                child: const Icon(
                  Icons.shopping_cart_rounded,
                  color: AppColors.primary,
                ),
              ),
              label: 'Keranjang',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon:
                  Icon(Icons.person_rounded, color: AppColors.primary),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
