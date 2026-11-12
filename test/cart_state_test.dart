import 'package:flutter_test/flutter_test.dart';
import 'package:toko_app/models/product.dart';
import 'package:toko_app/state/cart_state.dart';

void main() {
  group('CartState', () {
    late CartState cart;
    final product = dummyProducts.first;

    setUp(() {
      cart = CartState();
    });

    test('adds products and calculates count and total', () {
      cart.add(product);
      cart.add(product);

      expect(cart.count, 2);
      expect(cart.items, [product, product]);
      expect(cart.total, product.price * 2);
    });

    test('clear removes all items', () {
      cart
        ..add(product)
        ..add(dummyProducts[1])
        ..clear();

      expect(cart.isEmpty, isTrue);
      expect(cart.count, 0);
      expect(cart.total, 0);
    });
  });
}
