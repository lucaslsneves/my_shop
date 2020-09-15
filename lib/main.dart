import 'package:flutter/material.dart';
import 'package:my_shop/models/order.dart';
import 'package:my_shop/providers/auth.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/views/products_list_page.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'routes.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,Products>(
          create: (_) => Products([],null,null),
          update: (ctx,auth,previousProducts) => Products(previousProducts.products,auth.userId,auth.token),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth,Orders>(
          create: (_) => Orders(null,null,[]),
          update: (ctx,auth,previousOrders) => Orders(auth.token,auth.userId,previousOrders.orders),
        ),
        
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
       
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: Routes.AUTH,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
      ),
      body: Center(
        child: Text('Vamos desenvolver uma loja?'),
      ),
    );
  }
}
