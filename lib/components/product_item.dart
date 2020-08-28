import 'package:flutter/material.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class ProductItem extends StatelessWidget {
  goToProductDetail(BuildContext context, Product product) {
    Navigator.of(context).pushNamed(Routes.PRODUCT_DETAIL, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    Products products = Provider.of<Products>(context);
    return InkWell(
      onTap: () => goToProductDetail(context, product),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Theme.of(context).accentColor,
                  onPressed:(){
                    product.toogleFavorite();
                    products.setOnlyFavorites(products.showFavorite);
                  } ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.black87,
            trailing: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      cart.addToCart(product);
                    }),
                Text('${product.quantity.toStringAsFixed(0)}',style: TextStyle(color:Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
