# Kasir — Aplikasi Kasir Sederhana (Flutter)
Irgi Rangga Saputra - 23552011343

## Perbedaan Bloc dan Cubit

Cubit:

* Lebih sederhana
* Mengubah state langsung lewat emit()
* Boilerplate sedikit
* Cocok untuk logika ringan/sederhana

Bloc:
* Lebih kompleks
* Mengubah state lewat event → handler → emit
* Boilerplate lebih banyak
* Cocok untuk aplikasi besar & logika rumit
Ringkas: Cubit = simpel, Bloc = lebih terstruktur dan kompleks.

## Memisahkan model data, logika bisnis, dan UI penting karena:

1. Kode lebih rapi dan mudah dipahami — setiap bagian punya tugas jelas.
2. Mudah dirawat & dikembangkan — perubahan di satu bagian tidak merusak bagian lain.
3. Lebih mudah diuji (testable) — logika bisnis bisa diuji tanpa melibatkan UI.
4. Reuse kode lebih mudah — model dan logika bisa dipakai di banyak halaman.
5. Skalabilitas lebih baik — struktur tetap teratur meskipun aplikasi makin besar.

Singkatnya: memisahkan ketiganya membuat aplikasi lebih bersih, stabil, dan mudah dikembangkan.

## 3 contoh state yang umum digunakan dalam CartCubit

1. CartInitial / CartEmpty

Fungsi:
Menandakan keranjang masih kosong atau belum ada data yang dimuat.
Biasanya digunakan saat aplikasi baru dibuka atau cart belum terisi.

2. CartLoaded

Fungsi:
Menampung daftar item yang ada di keranjang beserta total harga atau jumlah item.
Dipakai saat user menambahkan, menghapus, atau mengubah jumlah barang, lalu UI diperbarui berdasarkan state ini.

3. CartError

Fungsi:
Menandakan terjadi kesalahan seperti gagal memuat data keranjang, gagal menambah item, atau masalah koneksi.
Memberikan UI kesempatan menampilkan pesan error.


Dokumentasi ini menjelaskan tujuan proyek, struktur file, alur data, dan panduan singkat untuk pengembang agar mudah memahami dan mengembangkan aplikasi.

## Ringkasan

- Aplikasi demo kasir sederhana (Flutter) yang menampilkan produk, memungkinkan menambahkan produk ke keranjang, melihat ringkasan keranjang, mengubah quantity, dan melakukan checkout (mengosongkan keranjang).
- State management menggunakan `flutter_bloc` (Cubit pattern) melalui `CartCubit`.

## Fitur Utama

- Daftar produk (Grid) dengan gambar, nama, dan harga.
- Featured / Favorit pada halaman Home (horizontal list).
- Tombol "Tambah" pada setiap produk untuk memasukkan produk ke keranjang.
- Badge keranjang di `AppBar` menampilkan jumlah total item (akumulasi quantity).
- Halaman Ringkasan Keranjang dengan kontrol `-`/`+` untuk mengubah quantity.
- Checkout: konfirmasi lalu memanggil `clearcart()` pada `CartCubit` untuk mengosongkan keranjang.

## Struktur Proyek (ringkas)

```
lib/
  main.dart
  blocs/
    cart_cubit.dart
  models/
    product_model.dart
  pages/
    cart_home_page.dart
    cart_grid_page.dart
    cart_summary_page.dart
  widgets
    product_card.dart
  main.dart
```


