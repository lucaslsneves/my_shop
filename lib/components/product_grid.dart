import 'package:flutter/material.dart';
import 'package:my_shop/components/product_item.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final List<Product> products = Provider.of<Products>(context).products;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (_, i) {
          return ChangeNotifierProvider.value(value: products[i],child: ProductItem());
        });
  }
}