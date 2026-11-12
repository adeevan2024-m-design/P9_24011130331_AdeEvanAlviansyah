import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product> onProductTap;

  const ProductListView({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('Produk tidak ditemukan.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: products.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final product = products[index];

        return Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  width: 64,
                  height: 64,
                  child: ColoredBox(
                    color: Color(0xFFE8EAF6),
                    child: Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
            ),
            title: Text(product.name),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(product.formattedPrice),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onProductTap(product),
          ),
        );
      },
    );
  }
}
