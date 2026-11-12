import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../state/auth_state.dart';
import '../theme/app_colors.dart';
import '../widgets/product_card.dart';
import '../widgets/product_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.authState, this.onSearchTap});

  final AuthState authState;

  
  final VoidCallback? onSearchTap;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _productsKey = GlobalKey();
  String? _category; // null = semua kategori

  static IconData _categoryIcon(String category) {
    switch (category) {
      case 'Olahraga':
        return Icons.directions_run_rounded;
      case 'Tas':
        return Icons.backpack_outlined;
      case 'Aksesori':
        return Icons.watch_outlined;
      case 'Elektronik':
        return Icons.headphones_outlined;
      case 'Perlengkapan':
        return Icons.water_drop_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  void _scrollToProducts() {
    final target = _productsKey.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  void _logout() {
    widget.authState.logout(); 
    context.go('/login'); 
  }

  @override
  Widget build(BuildContext context) {
    final username = widget.authState.username;
    final initial = username.isNotEmpty ? username[0].toUpperCase() : 'P';

    final items = _category == null
        ? dummyProducts
        : dummyProducts.where((p) => p.category == _category).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.brand,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white.withAlpha(56),
                            child: Text(
                              initial,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Halo, $username!',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Selamat datang di Toko App.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: 'Logout',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white.withAlpha(46),
                            ),
                            icon: const Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                            ),
                            onPressed: _logout,
                          ),
                        ],
                      ),
                      if (widget.onSearchTap != null) ...[
                        const SizedBox(height: 20),
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: widget.onSearchTap,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.search_rounded,
                                      color: AppColors.muted),
                                  SizedBox(width: 10),
                                  Text(
                                    'Cari produk...',
                                    style: TextStyle(color: AppColors.muted),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 18, 8, 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFF8A4C), Color(0xFFFF5E62)],
                  ),
                  boxShadow: AppColors.softShadow,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Koleksi Pilihan',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Perlengkapan harian terbaik untukmu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 14),
                          FilledButton.icon(
                            onPressed: _scrollToProducts,
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFFFF5E62),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            icon: const Icon(Icons.shopping_bag_rounded,
                                size: 18),
                            label: const Text(
                              'Lihat Daftar Produk',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ProductImage(
                        product: dummyProducts[1],
                        radius: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),

            
            const _SectionTitle(title: 'Kategori'),
            SizedBox(
              height: 92,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: productCategories.length - 1,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final category = productCategories[index + 1];
                  final selected = category == _category;
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    
                    onTap: () =>
                        setState(() => _category = selected ? null : category),
                    child: SizedBox(
                      width: 72,
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              color:
                                  selected ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: AppColors.softShadow,
                            ),
                            child: Icon(
                              _categoryIcon(category),
                              color:
                                  selected ? Colors.white : AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  selected ? FontWeight.w800 : FontWeight.w600,
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            
            KeyedSubtree(
              key: _productsKey,
              child: _SectionTitle(
                title: _category == null
                    ? 'Produk Pilihan'
                    : 'Produk $_category',
                actionLabel: _category == null ? null : 'Hapus filter',
                onAction: () => setState(() => _category = null),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final product = items[index];
                return ProductCard(
                  product: product,
                  hero: true,
                 
                  onTap: () => context.go('/home/product/${product.id}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 12, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ),
          if (actionLabel != null)
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}
