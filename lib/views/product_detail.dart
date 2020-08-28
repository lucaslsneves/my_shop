import 'package:flutter/material.dart';
import 'package:my_shop/components/app_drawer.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/models/product.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({this.product});

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.fill,
                ),
                width: double.infinity,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(fontSize: 26),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(
                          'R\$ ${product.price}',
                          style: TextStyle(fontSize: 26),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      product.description,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  
                  color: Theme.of(context).primaryColor,
                  child: Container(
                  padding: const EdgeInsets.symmetric(vertical:15),
                    width: double.infinity,
                    child: Text(
                    
                        'Adicionar ao carrinho',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                  ),
                  onPressed: () {
                    cart.addToCart(product);
                    Navigator.of(context).pushReplacementNamed(Routes.CART);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
