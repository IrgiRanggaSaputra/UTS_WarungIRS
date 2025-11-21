import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import '../blocs/cart_cubit.dart';
import 'cart_summary_page.dart';

class CartGridPage extends StatelessWidget {
  const CartGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy produk
    final products = [
      ProductModel(
        id: "1",
        name: "Kopi Hitam",
        price: 10000,
        image: "./lib/image/kopi.jpg",
      ),
      ProductModel(
        id: "2",
        name: "Es Teh",
        price: 5000,
        image: "./lib/image/esteh.jpg",
      ),
      ProductModel(
        id: "3",
        name: "Mie Goreng",
        price: 18000,
        image: "./lib/image/miegoreng.jpg",
      ),
      ProductModel(
        id: "4",
        name: "Nasi Goreng",
        price: 20000,
        image: "./lib/image/nasigoreng.jpg",
      ),
      ProductModel(
        id: "5",
        name: "Ayam Goreng",
        price: 25000,
        image: "./lib/image/ayam.jpg",
      ),
      ProductModel(
        id: "6",
        name: "Ayam geprek",
        price: 20000,
        image: "./lib/image/geprek.jpg",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Produk"),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final total = state.quantities.values.fold<int>(
                0,
                (s, e) => s + e,
              );
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const CartSummaryPage(),
                        ),
                      );
                    },
                  ),
                  if (total > 0)
                    Positioned(
                      right: 6,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '$total',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
