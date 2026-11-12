import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartState extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;
  double get total => _items.fold(0, (total, product) => total + product.price);
  bool get isEmpty => _items.isEmpty;

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeAt(int index) {
    if (index < 0 || index >= _items.length) return;
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }
}
