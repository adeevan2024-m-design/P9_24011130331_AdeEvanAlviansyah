import 'package:go_router/go_router.dart';

import '../pages/app_shell.dart';
import '../pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/not_found_page.dart';
import '../pages/product_detail_page.dart';
import '../pages/splash_screen.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../state/auth_state.dart';
import '../state/cart_state.dart';

GoRouter createRouter(AuthState authState, CartState cartState) {
 
  const publicRoutes = ['/splash', '/login'];

  
  GoRoute productDetailRoute() => GoRoute(
        path: 'product/:id', 
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          return ProductDetailPage(productId: id, cartState: cartState);
        },
      );

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    refreshListenable: authState,
    redirect: (context, state) {
      final loggedIn = authState.isLoggedIn;
      final goingPublic = publicRoutes.contains(state.matchedLocation);

      if (!loggedIn && !goingPublic) {
        final from = Uri.encodeComponent(state.uri.toString());
        return '/login?from=$from';
      }
      if (loggedIn && goingPublic) {
        return state.uri.queryParameters['from'] ?? '/home';
      }
      return null;
    },
    errorBuilder: (context, state) =>
        NotFoundPage(location: state.uri.toString()),
    routes: [
      
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(authState: authState),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppShell(
          navigationShell: navigationShell,
          cartState: cartState,
        ),
        branches: [
         
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => HomePage(
                authState: authState,
               
                onSearchTap: () => context.go('/search'),
              ),
              routes: [productDetailRoute()],
            ),
          ]),
          
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchPage(),
              routes: [productDetailRoute()],
            ),
          ]),
         
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/cart',
              builder: (context, state) => CartPage(cartState: cartState),
              routes: [
                GoRoute(
                  path: 'checkout', 
                  builder: (context, state) =>
                      CheckoutPage(cartState: cartState),
                ),
              ],
            ),
          ]),
          
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => ProfilePage(authState: authState),
            ),
          ]),
        ],
      ),
    ],
  );
}
