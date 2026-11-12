import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_illustration.dart';


class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
    this.radius = 20,
    this.padding = 14,
  });

  final Product product;
  final double radius;

  
  final double padding;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);
    final background = BoxDecoration(
      borderRadius: borderRadius,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          product.color.withAlpha(36),
          product.color.withAlpha(96),
        ],
      ),
    );

    return DecoratedBox(
      decoration: background,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Padding(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: ProductIllustration(
                  art: product.art,
                  color: product.color,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
