import 'package:flutter/material.dart';
import 'package:basket_app/cart_provider.dart';
import 'package:basket_app/product_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=>CartProvider(),
        child: Builder(builder: (BuildContext context){
          return MaterialApp(
            title: 'Hello World Demo Application',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const ProductListScreen(),
          );
        }));

  }
}

