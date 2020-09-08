import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';

class ProductEditItem extends StatelessWidget {
  final Product product;

  const ProductEditItem({this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage:NetworkImage(product.imageUrl),),
      title: Text(product.title),
      trailing: Row(mainAxisSize: MainAxisSize.min,children: [
         IconButton(icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,), onPressed: () {}),
        IconButton(icon: Icon(Icons.delete,color: Theme.of(context).errorColor,), onPressed: () {}),
       
      ],),
    );
  }
}