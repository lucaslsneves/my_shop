import 'package:flutter/material.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/auth.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class ProductItem extends StatelessWidget {
  goToProductDetail(BuildContext context, Product product) {
    Navigator.of(context).pushNamed(Routes.PRODUCT_DETAIL, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context);
    final auth = Provider.of<Auth>(context);
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
                  onPressed: () async {
                    try {
                     await product.toogleFavorite(auth.token,auth.userId);
                    }catch(e){
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Erro ao favoritar'),));
                    } 
                  }),
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
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).primaryColor,
                        content: Text(
                          'Produto adicionada ao carrinho',
                          style: TextStyle(fontSize: 16),
                          
                        ),
                        action: SnackBarAction(label: 'Desfazer',onPressed: () {
                          return cart.removeFromCartSnack(product);
                        },textColor: Theme.of(context).accentColor,),
                      ));
                    }),
                Text(
                  '${product.quantity.toStringAsFixed(0)}',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
