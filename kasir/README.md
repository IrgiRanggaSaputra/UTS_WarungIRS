# Kasir — Aplikasi Kasir Sederhana (Flutter)

README ini menjelaskan struktur proyek, alur data utama, dan penjabaran isi kode agar mudah dipahami dan dikembangkan.

## Ringkasan singkat
- Aplikasi demo: menampilkan daftar produk, menambah produk ke keranjang, melihat ringkasan keranjang, dan melakukan checkout (mengosongkan keranjang).
- State management menggunakan `flutter_bloc` (Cubit).

## Struktur proyek (file & folder penting)

```
lib/
  main.dart                  # Entrypoint, menyediakan BlocProvider untuk CartCubit
  blocs/
    cart_cubit.dart          # Cubit + CartState: logika keranjang (add, remove, update, clear)
  models/
    product_model.dart       # Model ProductModel (id, name, price, image)
  pages/
    cart_home_page.dart      # Home UI (greeting, search, featured, tombol ke grid/summary)
    cart_grid_page.dart      # Grid produk (dummy data), menampilkan ProductCard
    cart_summary_page.dart   # Ringkasan keranjang + checkout
  widgets/
    product_card.dart        # Kartu produk yang dipakai di Grid
pubspec.yaml                 # Dependencies (termasuk flutter_bloc)
README.md                    # (file ini)
```

## Penjelasan isi kode (per file penting)

- `lib/main.dart`
  - Memanggil `runApp()` dan membungkus `MaterialApp` dengan `BlocProvider(create: (_) => CartCubit())` sehingga `CartCubit` tersedia di seluruh widget tree.

- `lib/models/product_model.dart`
  - Kelas `ProductModel` dengan atribut: `id`, `name`, `price`, `image`.
  - Memiliki `toMap()` dan `fromMap()` untuk serialisasi (jika diperlukan menyimpan/restore).

- `lib/blocs/cart_cubit.dart`
  - `CartState` menyimpan:
    - `items`: List<ProductModel> — daftar produk unik di keranjang.
    - `quantities`: Map<String, int> — peta id produk ke jumlah.
  - `CartCubit` menyediakan fungsi:
    - `addToCart(product)`: tambahkan produk atau tambahkan qty jika sudah ada.
    - `removeFromCart(product)`: hapus produk sepenuhnya.
    - `updateQuantity(product, qty)`: set qty (atau hapus jika 0).
    - `getTotalItems()`: jumlah item total (akumulasi qty).
    - `getTotalPrice()`: total harga (sum price * qty).
    - `clearcart()`: reset state (kosongkan keranjang) — dipanggil saat Checkout.

  - Catatan: ada fungsi factory/state inisialisasi bernama `CCartInitial()` pada kode sekarang. Untuk konsistensi naming lebih baik diganti ke `CartState.initial()` atau serupa.

- `lib/widgets/product_card.dart`
  - Widget kartu produk yang menampilkan gambar, nama, harga, dan tombol "Tambah".
  - Ketika tombol ditekan memanggil `context.read<CartCubit>().addToCart(product)`.

- `lib/pages/cart_grid_page.dart`
  - Berisi data dummy `List<ProductModel>` dan menampilkan grid menggunakan `GridView.builder`.
  - AppBar menampilkan ikon keranjang dengan badge (menggunakan `BlocBuilder<CartCubit, CartState>` untuk membaca jumlah item).

- `lib/pages/cart_home_page.dart`
  - Home UI yang menampilkan greeting, search placeholder, featured horizontal list (card-card produk), dan tombol aksi besar.
  - Badge keranjang juga muncul di AppBar.
  - Featured cards memanggil `CartCubit.addToCart(product)` pada tombol "Tambah".

- `lib/pages/cart_summary_page.dart`
  - Menampilkan list item keranjang, kontrol `-`/`+` untuk mengurangi/menambah qty, serta tombol `Checkout`.
  - Tombol `Checkout` menampilkan dialog konfirmasi; jika disetujui memanggil `cartCubit.clearcart()` dan menampilkan snackbar.

## Alur data singkat

1. Produk ditampilkan (grid atau featured).
2. Pengguna menekan tombol "Tambah" → `CartCubit.addToCart(product)` dipanggil.
3. `CartCubit` memperbarui `CartState` dan memanggil `emit(...)`.
4. Widget yang menggunakan `BlocBuilder` akan rebuild (mis. badge di AppBar, list di `CartSummaryPage`).

## Cara menjalankan (PowerShell / Windows)

1. Di root proyek (tempat `pubspec.yaml` berada):
```powershell
flutter pub get
```
2. Jalankan analyzer (opsional):
```powershell
flutter analyze
```
3. Jalankan aplikasi (pilih device/emulator):
```powershell
flutter run
```

## Catatan & Troubleshooting

- Jika badge atau perubahan UI tidak muncul setelah modifikasi, lakukan full restart aplikasi (atau stop dan jalankan ulang `flutter run`).
- Pesan analyzer yang muncul saat ini sebagian besar berupa linter (info) seperti penamaan `CCartInitial` atau saran `use_super_parameters` — bukan error runtime.
- Gambar produk menggunakan `picsum.photos` sebagai placeholder; pastikan koneksi internet untuk melihat gambar.

## Rekomendasi perbaikan / next steps

- Refactor inisialisasi state: ganti `CCartInitial()` ke factory `CartState.initial()` atau sebutan konsisten untuk mengikuti konvensi Dart.
- Hapus import yang tidak terpakai untuk bersihkan lint warnings.
- Tambah persistence (shared_preferences / local DB) untuk menyimpan isi keranjang.
- Tambah halaman checkout yang menyimpan transaksi ke backend/file.

---

Jika Anda ingin, saya bisa:
- A) Terapkan perbaikan naming (`CartState.initial()`),
- B) Hapus import yang tidak terpakai di `cart_home_page.dart`, atau
- C) Jalankan aplikasi (`flutter run`) dan bantu debug tampilan secara langsung (membutuhkan emulator/device).

Beritahu pilihan Anda dan saya lanjutkan.
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

**Cara Menjalankan (PowerShell / Windows)**
1. Buka terminal di root proyek (folder yang berisi `pubspec.yaml`).
2. Ambil dependensi:
```powershell
flutter pub get
```
3. Jalankan analyzer untuk memastikan tidak ada error:
```powershell
flutter analyze
```
4. Jalankan aplikasi (pilih device/emulator):
```powershell
flutter run
```
- Jika sudah menjalankan dan melakukan perubahan UI, gunakan hot reload (`r`) atau full restart (`R`) di terminal tempat `flutter run` berjalan.

**Catatan Penggunaan**
- Tombol `Tambah` pada featured cards atau `ProductCard` memanggil `CartCubit.addToCart(product)`; jumlah total ditampilkan pada badge di `AppBar`.
- Tombol `Checkout` melakukan konfirmasi, lalu memanggil `CartCubit.clearcart()` — menampilkan snackbar dan kembali ke layar sebelumnya.
- Gambar produk menggunakan `https://picsum.photos` sebagai placeholder; jika tidak muncul periksa koneksi jaringan.

**Troubleshooting**
- Kalau ada error dependency, jalankan `flutter pub get` lagi.
- Jika badge atau perubahan UI tidak muncul setelah modifikasi, lakukan full restart aplikasi (atau stop dan `flutter run` ulang).
- Pesan analyzer yang muncul sebelumnya adalah linter/info (contoh: penamaan `CCartInitial` bukan lowerCamelCase). Ini tidak menghentikan aplikasi dari berjalan, tetapi bisa diperbaiki untuk memenuhi linter.

**Saran Perbaikan / Next Steps**
- Perbaiki naming lint di `lib/blocs/cart_cubit.dart` (ganti `CCartInitial` ke `cartInitial` atau sediakan factory `CartState.initial()`).
- Tambah persistent storage (mis. `shared_preferences` atau local DB) untuk menyimpan isi keranjang.
- Tambah halaman Checkout yang menyimpan transaksi ke backend atau file.

Jika mau, saya bisa:
- A) Jalankan `flutter run` dan memeriksa log secara langsung (butuh emulator/device), atau
- B) Terapkan perbaikan lint (ganti `CCartInitial` ke pattern `CartState.initial()`), atau
- C) Menghapus import yang tidak terpakai pada `CartHomePage`.

Pilih langkah berikut yang Anda inginkan, atau beri tahu perubahan visual spesifik yang ingin Anda terapkan pada Home UI.
