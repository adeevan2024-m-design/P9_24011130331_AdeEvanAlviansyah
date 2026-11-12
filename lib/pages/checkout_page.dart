import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../state/cart_state.dart';
import '../theme/app_colors.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.cartState});

  final CartState cartState;

  void _pay(BuildContext context) {
    cartState.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pembayaran berhasil. Terima kasih!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    context.go('/cart'); 
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: cartState,
      builder: (context, child) {
        final isEmpty = cartState.count == 0;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Checkout',
              style:
                  TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
            ),
            backgroundColor: AppColors.surface,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppColors.softShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ringkasan Pesanan',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Jumlah barang',
                              style: TextStyle(color: AppColors.muted),
                            ),
                          ),
                          Text(
                            '${cartState.count}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 28),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Total bayar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            formatRupiah(cartState.total),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Keranjang kosong, tidak ada yang perlu dibayar.',
                    style: TextStyle(color: AppColors.muted),
                  ),
                ],
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: isEmpty ? null : () => _pay(context),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Bayar Sekarang',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
