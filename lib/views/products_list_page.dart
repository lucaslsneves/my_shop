import 'package:flutter/material.dart';
import 'package:my_shop/components/product_item.dart';
import 'package:my_shop/data/dummy_data.dart';
import 'package:my_shop/models/product.dart';

class ProductsListPage extends StatelessWidget {
  final List<Product> products = DUMMY_PRODUCTS;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: products.length,
            itemBuilder: (_, i) {
              return ProductItem(product: products[i]);
            }),
      ),
    );
  }
}
