import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/app_shell.dart';
import '../pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/not_found_page.dart';
import '../pages/product_detail_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../state/auth_state.dart';
import '../state/cart_state.dart';
import 'app_routes.dart';

GoRouter createAppRouter({
  required AuthState authState,
  required CartState cartState,
}) {
  final homeNavigatorKey = GlobalKey<NavigatorState>();
  final searchNavigatorKey = GlobalKey<NavigatorState>();
  final cartNavigatorKey = GlobalKey<NavigatorState>();
  final profileNavigatorKey = GlobalKey<NavigatorState>();
  const publicRoutes = {AppRoutes.login};

  return GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: authState,
    redirect: (context, state) {
      final path = state.uri.path;
      if (!authState.isLoggedIn && !publicRoutes.contains(path)) {
        return Uri(
          path: AppRoutes.login,
          queryParameters: {'from': state.uri.toString()},
        ).toString();
      }

      if (authState.isLoggedIn && publicRoutes.contains(path)) {
        final destination = state.uri.queryParameters['from'];
        if (destination != null &&
            destination.startsWith('/') &&
            !destination.startsWith('//')) {
          return destination;
        }
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginPage(
          authState: authState,
          fromLocation: state.uri.queryParameters['from'] ?? AppRoutes.home,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppShell(
          navigationShell: navigationShell,
          cartState: cartState,
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => HomePage(authState: authState),
                routes: [
                  GoRoute(
                    path: 'product/:id',
                    builder: (context, state) => _productDetailRoute(
                      state,
                      cartState,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: searchNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.search,
                builder: (context, state) => const SearchPage(),
                routes: [
                  GoRoute(
                    path: 'product/:id',
                    builder: (context, state) => _productDetailRoute(
                      state,
                      cartState,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: cartNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.cart,
                builder: (context, state) => CartPage(cartState: cartState),
                routes: [
                  GoRoute(
                    path: 'checkout',
                    builder: (context, state) =>
                        CheckoutPage(cartState: cartState),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: profileNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => ProfilePage(authState: authState),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        NotFoundPage(location: state.uri.toString()),
  );
}

Widget _productDetailRoute(GoRouterState state, CartState cartState) {
  return ProductDetailPage(
    productId: state.pathParameters['id'] ?? '',
    cartState: cartState,
  );
}
