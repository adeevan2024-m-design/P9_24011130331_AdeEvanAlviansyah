import 'package:flutter_test/flutter_test.dart';
import 'package:toko_app/models/product.dart';

void main() {
  test('formats prices as Indonesian rupiah', () {
    expect(formatRupiah(450000), 'Rp 450.000');
    expect(dummyProducts.first.formattedPrice, 'Rp 450.000');
  });

  test('finds a product by ID and returns null for an unknown ID', () {
    expect(findProductById(3)?.name, 'Jam Tangan');
    expect(findProductById(99), isNull);
  });
}
