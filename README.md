# Rizora Cafe - Flutter Project

Aplikasi ini dibuat untuk memenuhi tugas UTS Flutter. Tema aplikasi adalah pemesanan makanan/minuman di cafe.
Di dalam aplikasi ini pengguna bisa melihat daftar menu, melihat detail makanan, dan memasukkan pesanan ke keranjang.

## Fitur Utama
1. Halaman Home
   - Menampilkan list menu makanan dan minuman.
   - Ada header dan beberapa layout dasar seperti Row, Column, Padding, dll.
   - Bisa klik salah satu menu untuk melihat detailnya.
2. Halaman Detail
   - Menampilkan gambar makanan dengan efek Stack + Positioned.
   - Pengguna bisa menambah atau mengurangi jumlah pesanan.
   - Tombol "Pesan Sekarang" untuk masuk ke keranjang.
3. Halaman Keranjang
   - Menampilkan daftar pesanan yang sudah dipilih.
   - Bisa hapus item dari keranjang.
   - Ada input nomor meja dan nama pemesan.
   - Tombol untuk mengirim pesanan ke kasir.

## Cara Menjalankan Aplikasi
1. Pastikan Flutter sudah terinstall
2. Jalankan perintah:
   flutter pub get
3. Lalu:
   flutter run   
4. Pastikan folder assets/images sudah ada dan sudah di-register di pubspec.yaml.
