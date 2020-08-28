import 'package:flutter/material.dart';
import 'package:my_shop/components/app_drawer.dart';
import 'package:my_shop/components/badge.dart';
import 'package:my_shop/components/product_grid.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

class ProductsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Products products = Provider.of<Products>(context, listen: false);
    
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          Consumer<Cart>(
            child:IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
              ) ,
            builder: (ctx, cart, child) => Badge(
              child: child,
              value: '${cart.getCartAmout.toStringAsFixed(0)}',
            ),
          ),
          PopupMenuButton(
            onSelected: (bool value) {
              products.setOnlyFavorites(value);
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente favoritos'),
                value: true,
              ),
              PopupMenuItem(child: Text('Todos'), value: false),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductGrid(),
      ),
    );
  }
}
