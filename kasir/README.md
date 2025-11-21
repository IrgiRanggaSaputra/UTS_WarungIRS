# Kasir — Aplikasi Kasir Sederhana (Flutter)

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

**Kasir — Aplikasi Kasir Sederhana (Flutter)**

- **Project**: Aplikasi kasir Flutter sederhana untuk menampilkan produk, menambah ke keranjang, melihat ringkasan, dan checkout (mengosongkan keranjang).

**Fitur Utama**
- **Daftar produk**: Grid produk dengan gambar, nama, dan harga.
- **Favorit / Featured**: Tampilan horizontal pada Home.
- **Keranjang**: Badge di pojok kanan atas pada `AppBar` (jumlah item aktif).
- **Ringkasan Keranjang**: Melihat item, ubah quantity, dan hapus.
- **Checkout**: Tombol `Checkout` di halaman ringkasan yang memanggil `clearcart()` pada `CartCubit` dan mengosongkan keranjang.

**Perubahan Penting (file)**
- `pubspec.yaml`: menambahkan dependency `flutter_bloc`.
- `lib/blocs/cart_cubit.dart`: menambah method `clearcart()` serta manajemen state keranjang.
- `lib/pages/cart_home_page.dart`: UI home diperbarui (greeting, search placeholder, featured cards, tombol aksi) dan tetap menampilkan badge keranjang.
- `lib/pages/cart_grid_page.dart`: AppBar menampilkan badge keranjang; menampilkan grid produk dummy.
- `lib/pages/cart_summary_page.dart`: menambahkan tombol `Checkout` dengan konfirmasi dialog.

**Requirement**
- Flutter SDK (sesuai `environment` di `pubspec.yaml`).
- Device atau emulator yang terhubung untuk menjalankan aplikasi.
