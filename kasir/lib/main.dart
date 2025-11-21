import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cart_cubit.dart';
import 'pages/cart_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplikasi Kasir',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: false, // ubah ke true jika ingin Material 3
        ),
        home: const CartHomePage(),
      ),
    );
  }
}
