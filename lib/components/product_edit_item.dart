import 'package:flutter/material.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class ProductEditItem extends StatelessWidget {
  final Product product;

  const ProductEditItem({this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
        backgroundColor: Colors.transparent,
      ),
      title: Text(product.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.PRODUCTS_FORM,
                    arguments: product);
              }),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      
                          actions: [
                            FlatButton(
                              child: Text('Sim',style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Provider.of<Products>(context, listen: false)
                                    .removeProduct(product);
                                Provider.of<Cart>(context, listen: false)
                                    .removeAllFromCart(product);
                                  Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Não',style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                 Navigator.of(context).pop();
                              },
                            )
                          ],
                          backgroundColor: Theme.of(context).primaryColor,
                          title: Text(
                              'Você tem certeza que quer remover o produto?',style: TextStyle(color: Colors.white),),
                          content: Text('O produto será removido para sempre',style: TextStyle(color: Colors.white)),
                        ));
              }),
        ],
      ),
    );
  }
}
