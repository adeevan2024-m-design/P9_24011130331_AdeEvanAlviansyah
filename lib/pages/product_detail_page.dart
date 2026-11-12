import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../state/cart_state.dart';
import '../theme/app_colors.dart';
import '../widgets/product_image.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.productId,
    required this.cartState,
  });

  /// id dari path parameter URL (/home/product/:id). Null jika bukan angka.
  final int? productId;
  final CartState cartState;

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text(
        'Detail Produk',
        style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
      ),
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = productId;
    final product = id == null ? null : findProductById(id);

    // id tidak valid / produk tidak ada (mis. /home/product/99)
    if (product == null) {
      return Scaffold(
        appBar: _appBar(),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 64,
                  color: AppColors.muted,
                ),
                SizedBox(height: 12),
                Text(
                  'Produk tidak ditemukan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          Hero(
            tag: 'product-image-${product.id}',
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: ProductImage(product: product, radius: 28, padding: 28),
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Foto: ${product.photoCredit} / Unsplash',
              style: const TextStyle(fontSize: 11, color: AppColors.muted),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: product.color.withAlpha(40),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.category,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: HSLColor.fromColor(product.color)
                        .withLightness(0.32)
                        .toColor(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            product.formattedPrice,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _StatTile(
                icon: Icons.star_rounded,
                iconColor: AppColors.star,
                label: 'Rating',
                value: product.ratingLabel,
              ),
              const SizedBox(width: 12),
              _StatTile(
                icon: Icons.local_mall_outlined,
                iconColor: AppColors.primary,
                label: 'Terjual',
                value: product.soldLabel,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.details,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Keunggulan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final spec in product.specs)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        spec,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A1F2937),
              blurRadius: 20,
              offset: Offset(0, -6),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Harga',
                      style: TextStyle(fontSize: 12, color: AppColors.muted),
                    ),
                    Text(
                      product.formattedPrice,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: () {
                        cartState.add(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} ditambahkan ke keranjang',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        // Kembali ke halaman sebelumnya di tab ini
                        // (go ke tab Beranda jika dibuka lewat deep link)
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/home');
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.add_shopping_cart_rounded),
                      label: const Text(
                        'Tambah ke Keranjang',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppColors.softShadow,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: AppColors.muted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
