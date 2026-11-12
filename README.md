# Toko App

Aplikasi demo toko online sederhana yang dibuat dengan Flutter. Aplikasi ini
memiliki tampilan untuk web dan Android, dengan alur login, pencarian produk,
keranjang, dan checkout demo.

## Identitas

- Nama: **maulvinazirrahmat**
- NIM: **240111465**

## Tautan

- Profil GitHub: [maulvinazir87-cmd](https://github.com/maulvinazir87-cmd)
- Repository: [Toko App di GitHub](https://github.com/maulvinazir87-cmd/-P9_24011130465_MaulviNazirRahmat.pdf)

## Fitur

- Login dan logout menggunakan nama pengguna.
- Halaman yang memerlukan login dilindungi dan diarahkan ke halaman login.
- Menampilkan daftar produk, detail produk, dan pencarian berdasarkan nama atau deskripsi.
- Menambahkan dan menghapus produk dari keranjang, termasuk jumlah dan total harga.
- Alur checkout demo dengan ringkasan pesanan.
- Navigasi bawah untuk Beranda, Cari, Keranjang, dan Profil.
- Halaman tidak ditemukan untuk rute yang tidak tersedia.

## Teknologi

- Flutter dan Dart
- Material 3
- `go_router` untuk navigasi dan perlindungan rute

## Menjalankan aplikasi web

Pastikan Flutter SDK dan Google Chrome sudah tersedia, lalu jalankan dari root
proyek:

```bash
flutter pub get
flutter run -d chrome --web-port 8080
```

Setelah aplikasi berjalan, buka [http://localhost:8080](http://localhost:8080).

Untuk menjalankan di Android, hubungkan perangkat atau mulai emulator, lalu:

```bash
flutter run -d android
```

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
  widgets/      Widget yang digunakan bersama
web/            Berkas platform web
test/           Pengujian aplikasi
```

## Catatan

Data produk bersifat contoh. Login dan keranjang disimpan di memori selama
aplikasi berjalan. Checkout hanya simulasi dan belum terhubung ke backend
atau layanan pembayaran.
