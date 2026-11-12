# Identitas

- **Nama:** Ade Evan Alviansyah
- **NIM:** 24011130331
- **GitHub:** [adeevan2024-m-design](https://github.com/adeevan2024-m-design)
- **Repository:** [P9_24011130331_AdeEvanAlviansyah](https://github.com/adeevan2024-m-design/P9_24011130331_AdeEvanAlviansyah)

# Toko App

Toko App adalah aplikasi demo toko online yang dibuat menggunakan Flutter.
Aplikasi ini menyediakan katalog produk dan alur belanja sederhana, serta
dapat dijalankan di Android dan web.

## Fitur

- Login dan logout demo menggunakan nama pengguna.
- Katalog produk dengan gambar yang dimuat dari Unsplash.
- Pencarian produk berdasarkan nama atau deskripsi.
- Halaman detail produk.
- Keranjang belanja dengan pengaturan jumlah dan total harga.
- Alur checkout demo dengan ringkasan pesanan.
- Navigasi Beranda, Cari, Keranjang, dan Profil.
- Pengalihan ke halaman login untuk rute yang memerlukan autentikasi.

## Teknologi

- Flutter dan Dart
- Material 3
- `go_router` untuk navigasi dan perlindungan rute

## Persiapan

Pastikan Flutter SDK telah terpasang, lalu jalankan dari direktori proyek:

```bash
flutter pub get
```

### Menjalankan di web

Pastikan Google Chrome tersedia, lalu jalankan:

```bash
flutter run -d chrome --web-port 8080
```

Buka [http://localhost:8080](http://localhost:8080) jika browser tidak terbuka
secara otomatis.

### Menjalankan di Android

Hubungkan perangkat Android atau mulai emulator. Periksa ID perangkat dengan
`flutter devices`, kemudian jalankan:

```bash
flutter run -d <device-id>
```

Perangkat perlu terhubung ke internet untuk memuat gambar produk dari Unsplash.

## Pengujian dan analisis

```bash
flutter test
flutter analyze
```

## Struktur proyek

```text
lib/
  models/       Model produk
  pages/        Halaman aplikasi
  router/       Konfigurasi rute
  state/        State login dan keranjang
  theme/        Tema dan warna aplikasi
  widgets/      Widget yang digunakan bersama
web/            Berkas platform web
test/           Pengujian aplikasi
```

## Catatan

Data produk bersifat contoh. Login dan keranjang disimpan di memori selama
aplikasi berjalan. Checkout hanya simulasi dan belum terhubung ke backend
atau layanan pembayaran.
