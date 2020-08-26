import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';
import '../providers/counter_provider.dart';
class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
     
    );
  }
}
