import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../router/app_routes.dart';
import '../state/cart_state.dart';

class CheckoutPage extends StatelessWidget {
  final CartState cartState;

  const CheckoutPage({super.key, required this.cartState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: AnimatedBuilder(
        animation: cartState,
        builder: (context, _) {
          final items = cartState.items;
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Belum ada produk untuk checkout.'),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => context.go(AppRoutes.home),
                      child: const Text('Kembali ke Beranda'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Ringkasan Pesanan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              for (final product in items)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(product.name),
                  trailing: Text(product.formattedPrice),
                ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    formatRupiah(cartState.total),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  cartState.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pembayaran berhasil.'),
                    ),
                  );
                  context.go(AppRoutes.cart);
                },
                child: const Text('Bayar Sekarang'),
              ),
            ],
          );
        },
      ),
    );
  }
}
