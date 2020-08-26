import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);

  goToProductDetail(BuildContext context){
    Navigator.of(context).pushNamed(Routes.PRODUCT_DETAIL,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final toogleFavorite = Provider.of<Products>(context).toogleFavorite;
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
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () => toogleFavorite(product.id)),
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
