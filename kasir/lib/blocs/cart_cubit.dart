import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';

class CartState {
  final List<ProductModel> items; // daftar produk unik
  final Map<String, int> quantities; // id -> qty

  CartState({required this.items, required this.quantities});

  CartState copyWith({
    List<ProductModel>? items,
    Map<String, int>? quantities,
  }) {
    return CartState(
      items: items ?? this.items,
      quantities: quantities ?? this.quantities,
    );
  }
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CCartInitial());

  /// Inisialisasi default state
  static CartState CCartInitial() => CartState(items: [], quantities: {});

  /// Tambah produk ke keranjang
  void addToCart(ProductModel product) {
    final items = List<ProductModel>.from(state.items);
    final quantities = Map<String, int>.from(state.quantities);

    // Jika produk sudah ada, tambahkan qty
    if (quantities.containsKey(product.id)) {
      quantities[product.id] = quantities[product.id]! + 1;
    } else {
      items.add(product);
      quantities[product.id] = 1;
    }

    emit(state.copyWith(items: items, quantities: quantities));
  }

  /// Hapus produk dari keranjang
  void removeFromCart(ProductModel product) {
    final items = List<ProductModel>.from(state.items);
    final quantities = Map<String, int>.from(state.quantities);

    if (quantities.containsKey(product.id)) {
      quantities.remove(product.id);
      items.removeWhere((p) => p.id == product.id);
    }

    emit(state.copyWith(items: items, quantities: quantities));
  }

  /// Update jumlah item (qty)
  void updateQuantity(ProductModel product, int qty) {
    final items = List<ProductModel>.from(state.items);
    final quantities = Map<String, int>.from(state.quantities);

    if (qty <= 0) {
      // jika qty 0 hapus item
      removeFromCart(product);
      return;
    }

    quantities[product.id] = qty;
    emit(state.copyWith(items: items, quantities: quantities));
  }

  /// Total item di keranjang (akumulasi qty)
  int getTotalItems() {
    return state.quantities.values.fold(0, (sum, qty) => sum + qty);
  }

  /// Total harga
  int getTotalPrice() {
    int total = 0;

    for (var product in state.items) {
      final qty = state.quantities[product.id] ?? 0;
      total += product.price * qty;
    }

    return total;
  }

  /// Kosongkan keranjang (checkout)
  void clearcart() {
    emit(CCartInitial());
  }
}
