class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const search = '/search';
  static const cart = '/cart';
  static const checkout = '/cart/checkout';
  static const profile = '/profile';

  static String homeProduct(int productId) => '/home/product/$productId';
  static String searchProduct(int productId) => '/search/product/$productId';
}
