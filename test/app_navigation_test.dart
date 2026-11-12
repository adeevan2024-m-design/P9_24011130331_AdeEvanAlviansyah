import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toko_app/router/app_router.dart';
import 'package:toko_app/state/auth_state.dart';
import 'package:toko_app/state/cart_state.dart';

void main() {
  testWidgets('splash redirects to login and login opens the home page', (
    tester,
  ) async {
    final authState = AuthState();
    final cartState = CartState();
    final router = createRouter(authState, cartState);
    addTearDown(() {
      router.dispose();
      authState.dispose();
      cartState.dispose();
    });

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Silakan login untuk membuka /home'), findsOneWidget);
    expect(router.routeInformationProvider.value.uri.path, '/login');

    await tester.enterText(find.byType(TextField).at(0), 'Ayu');
    await tester.enterText(find.byType(TextField).at(1), 'password');
    await tester.tap(find.widgetWithText(FilledButton, 'Masuk'));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, '/home');
    expect(find.text('Halo, Ayu!'), findsOneWidget);

    authState.logout();
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/login');
    expect(find.text('Silakan login untuk membuka /home'), findsOneWidget);
  });
}
