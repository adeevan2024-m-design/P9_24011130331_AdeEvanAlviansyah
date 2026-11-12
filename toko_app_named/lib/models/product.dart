import 'package:flutter/material.dart';

/// Jenis ilustrasi produk. Dipakai sebagai cadangan (fallback) kalau foto
/// produk gagal dimuat, misalnya saat tidak ada internet.
enum ProductArt { shoes, backpack, watch, headphone, bottle }

// Format harga: 450000 -> "Rp 450.000"
String formatRupiah(num value) {
  final s = value.toStringAsFixed(0);
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
    buffer.write(s[i]);
  }
  return 'Rp $buffer';
}

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String details;
  final String imageUrl;
  final String photoCredit;
  final String category;
  final ProductArt art;
  final Color color;
  final double rating;
  final int sold;
  final List<String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.details,
    required this.imageUrl,
    required this.photoCredit,
    required this.category,
    required this.art,
    required this.color,
    required this.rating,
    required this.sold,
    required this.specs,
  });

  String get formattedPrice => formatRupiah(price);

  String get ratingLabel => rating.toStringAsFixed(1).replaceAll('.', ',');

  String get soldLabel => sold >= 1000
      ? '${(sold / 1000).toStringAsFixed(1).replaceAll('.', ',')} rb'
      : '$sold';
}

const List<Product> dummyProducts = [
  Product(
    id: 1,
    name: 'Sepatu Lari',
    price: 450000,
    description: 'Sepatu lari ringan dengan sol empuk untuk latihan harian.',
    details:
        'Dirancang untuk menemani latihan lari sehari-hari. Bobotnya ringan sehingga langkah terasa enteng, sementara sol yang empuk membantu meredam hentakan saat kaki menapak. Cocok dipakai untuk jogging pagi, latihan rutin di taman, maupun olahraga ringan lainnya.',
    imageUrl:
        'https://images.unsplash.com/photo-1571008887538-b36bb32f4571?auto=format&fit=crop&w=900&q=80',
    photoCredit: 'sporlab',
    category: 'Olahraga',
    art: ProductArt.shoes,
    color: Color(0xFFFF6B35),
    rating: 4.8,
    sold: 1200,
    specs: ['Bobot ringan', 'Sol empuk', 'Untuk latihan harian'],
  ),
  Product(
    id: 2,
    name: 'Tas Ransel',
    price: 275000,
    description: 'Ransel 20 liter dengan slot laptop 14 inci.',
    details:
        'Ransel berkapasitas 20 liter yang pas untuk aktivitas harian, mulai dari kuliah, bekerja, hingga bepergian singkat. Tersedia slot khusus laptop hingga 14 inci agar perangkat tetap rapi dan terlindungi, dengan ruang tambahan untuk buku, botol minum, dan perlengkapan lainnya.',
    imageUrl:
        'https://images.unsplash.com/photo-1681334921874-5bafe8acf433?auto=format&fit=crop&w=900&q=80',
    photoCredit: 'Erik Mclean',
    category: 'Tas',
    art: ProductArt.backpack,
    color: Color(0xFF2F6FED),
    rating: 4.7,
    sold: 860,
    specs: ['Kapasitas 20 liter', 'Slot laptop 14 inci', 'Untuk aktivitas harian'],
  ),
  Product(
    id: 3,
    name: 'Jam Tangan',
    price: 820000,
    description: 'Jam tangan analog tahan air hingga 50 meter.',
    details:
        'Jam tangan analog bergaya klasik dengan penunjuk waktu berupa jarum yang mudah dibaca. Tahan air hingga 50 meter, sehingga aman dari cipratan air, hujan, dan saat mencuci tangan. Tampil rapi untuk bekerja maupun acara santai.',
    imageUrl:
        'https://images.unsplash.com/photo-1432832372508-de66fd1f6557?auto=format&fit=crop&w=900&q=80',
    photoCredit: 'Evran Jawad',
    category: 'Aksesori',
    art: ProductArt.watch,
    color: Color(0xFFB7791F),
    rating: 4.9,
    sold: 540,
    specs: ['Tampilan analog', 'Tahan air hingga 50 meter', 'Gaya klasik'],
  ),
  Product(
    id: 4,
    name: 'Headphone',
    price: 650000,
    description: 'Headphone nirkabel dengan baterai tahan 30 jam.',
    details:
        'Headphone nirkabel yang bebas dari kabel kusut. Baterainya tahan hingga 30 jam pemakaian, jadi cukup diisi daya sesekali untuk menemani perjalanan, bekerja, atau mendengarkan musik favorit seharian.',
    imageUrl:
        'https://images.unsplash.com/photo-1553774661-0651f14b2da4?auto=format&fit=crop&w=900&q=80',
    photoCredit: 'Petr Macháček',
    category: 'Elektronik',
    art: ProductArt.headphone,
    color: Color(0xFF7C3AED),
    rating: 4.6,
    sold: 980,
    specs: ['Nirkabel', 'Baterai tahan 30 jam', 'Praktis dibawa bepergian'],
  ),
  Product(
    id: 5,
    name: 'Botol Minum',
    price: 95000,
    description: 'Botol stainless 750 ml, menjaga suhu hingga 12 jam.',
    details:
        'Botol minum stainless steel berkapasitas 750 ml, cukup untuk kebutuhan minum sepanjang aktivitas. Mampu menjaga suhu minuman hingga 12 jam, sehingga minuman dingin tetap segar dan minuman hangat tetap hangat.',
    imageUrl:
        'https://images.unsplash.com/photo-1544003484-3cd181d17917?auto=format&fit=crop&w=900&q=80',
    photoCredit: 'Karl Köhler',
    category: 'Perlengkapan',
    art: ProductArt.bottle,
    color: Color(0xFF14B8A6),
    rating: 4.8,
    sold: 2300,
    specs: ['Kapasitas 750 ml', 'Bahan stainless', 'Suhu terjaga hingga 12 jam'],
  ),
];

final List<String> productCategories = [
  'Semua',
  ...{for (final p in dummyProducts) p.category},
];
