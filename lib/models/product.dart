class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  String get formattedPrice => formatRupiah(price);
}

String formatRupiah(double value) {
  final roundedValue = value.round();
  final digits = roundedValue.abs().toString();
  final buffer = StringBuffer();

  if (roundedValue < 0) buffer.write('-');
  buffer.write('Rp ');
  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && (digits.length - index) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[index]);
  }
  return buffer.toString();
}

Product? findProductById(int id) {
  for (final product in dummyProducts) {
    if (product.id == id) return product;
  }
  return null;
}

const List<Product> dummyProducts = [
  Product(
    id: 1,
    name: 'Sepatu Lari',
    price: 450000,
    imageUrl: 'https://picsum.photos/seed/sepatu/400/300',
    description: 'Sepatu lari ringan dengan sol empuk untuk latihan harian.',
  ),
  Product(
    id: 2,
    name: 'Tas Ransel',
    price: 275000,
    imageUrl: 'https://picsum.photos/seed/ransel/400/300',
    description: 'Ransel 20 liter dengan slot laptop 14 inci.',
  ),
  Product(
    id: 3,
    name: 'Jam Tangan',
    price: 820000,
    imageUrl: 'https://picsum.photos/seed/jam/400/300',
    description: 'Jam tangan analog tahan air hingga 50 meter.',
  ),
  Product(
    id: 4,
    name: 'Headphone',
    price: 650000,
    imageUrl: 'https://picsum.photos/seed/headphone/400/300',
    description: 'Headphone nirkabel dengan baterai tahan 30 jam.',
  ),
  Product(
    id: 5,
    name: 'Botol Minum',
    price: 95000,
    imageUrl: 'https://picsum.photos/seed/botol/400/300',
    description: 'Botol stainless 750 ml, menjaga suhu hingga 12 jam.',
  ),
];
