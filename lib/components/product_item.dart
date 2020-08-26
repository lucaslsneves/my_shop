import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';

import '../routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);

  goToProductDetail(BuildContext context){
    Navigator.of(context).pushNamed(Routes.PRODUCT_DETAIL,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () => goToProductDetail(context),
          child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
            child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            leading: IconButton(
                icon: Icon(Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () {}),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.black87,
            trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Theme.of(context).accentColor,
                onPressed: () {}),
          ),
        ),
      ),
    );
  }
}
