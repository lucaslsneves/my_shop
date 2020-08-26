import 'package:flutter/material.dart';
import 'package:my_shop/components/product_grid.dart';



class ProductsListPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductGrid(),
      ),
    );
  }
}


