import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toko_app/models/product.dart';
import 'package:toko_app/pages/cart_page.dart';
import 'package:toko_app/pages/product_detail_page.dart';
import 'package:toko_app/state/auth_state.dart';
import 'package:toko_app/state/cart_state.dart';
import 'package:toko_app/router/app_router.dart';

void main() {
  testWidgets('protected routes, cart flow, tabs, and 404 work', (
    tester,
  ) async {
    final authState = AuthState();
    final cartState = CartState();
    final router = createAppRouter(
      authState: authState,
      cartState: cartState,
    );
    addTearDown(() {
      router.dispose();
      authState.dispose();
      cartState.dispose();
    });

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('Silakan login untuk membuka /home.'), findsOneWidget);

    router.go('/home/product/1');
    await tester.pumpAndSettle();
    expect(
      find.text('Silakan login untuk membuka /home/product/1.'),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextFormField).at(0), 'Ayu');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    router.go('/home/product/1');
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/home/product/1');
    expect(find.text('Produk tidak ditemukan'), findsNothing);
    expect(find.text(dummyProducts.first.name), findsWidgets);
    final homeDetailList = find.descendant(
      of: find.byType(ProductDetailPage),
      matching: find.byType(ListView),
    );
    await tester.drag(homeDetailList, const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('Tambah ke Keranjang'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Cari'), findsOneWidget);
    expect(find.text('Keranjang'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);

    await _tapTab(tester, 'Profil');
    await _tapTab(tester, 'Beranda');
    expect(find.text('Tambah ke Keranjang'), findsOneWidget);

    await _tapTab(tester, 'Beranda');
    expect(find.text('Daftar Produk'), findsOneWidget);

    await _tapTab(tester, 'Cari');
    await tester.enterText(find.byType(TextField), 'ja');
    await tester.pumpAndSettle();
    expect(find.text('Jam Tangan'), findsOneWidget);

    await _tapTab(tester, 'Beranda');
    await _tapTab(tester, 'Cari');
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text,
        'ja');

    await tester.tap(find.text('Jam Tangan'));
    await tester.pumpAndSettle();
    final searchDetailList = find.descendant(
      of: find.byType(ProductDetailPage),
      matching: find.byType(ListView),
    );
    await tester.drag(searchDetailList, const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('Tambah ke Keranjang'), findsOneWidget);
    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Tambah ke Keranjang'), findsNothing);

    await _tapTab(tester, 'Keranjang');
    expect(router.routeInformationProvider.value.uri.path, '/cart');
    expect(find.byType(CartPage), findsOneWidget);
    expect(find.text('Jam Tangan'), findsOneWidget);
    expect(find.text('Lanjut ke Checkout'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      2,
    );
    await tester.ensureVisible(find.text('Lanjut ke Checkout'));
    await tester.tap(find.text('Lanjut ke Checkout'));
    await tester.pumpAndSettle();
    expect(find.text('Bayar Sekarang'), findsOneWidget);
    expect(
      router.routeInformationProvider.value.uri.path,
      '/cart/checkout',
    );
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('Bayar Sekarang'));
    await tester.pumpAndSettle();
    expect(find.text('Keranjang masih kosong.'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    router.go('/home/product/99');
    await tester.pumpAndSettle();
    expect(find.text('Produk tidak ditemukan'), findsOneWidget);

    router.go('/halaman-acak');
    await tester.pumpAndSettle();
    expect(find.text('404 - Halaman Tidak Ditemukan'), findsOneWidget);

    router.go('/profile');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(router.canPop(), isFalse);
  });
}

Future<void> _tapTab(WidgetTester tester, String label) async {
  await tester.tap(
    find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text(label),
    ),
  );
  await tester.pumpAndSettle();
}
