import 'package:flutter/material.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/models/product.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Product product;
  CartItem(this.product);
  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return Dismissible(
      onDismissed: ((_) => cart.removeAllFromCart(product)),
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 5,
        child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  product.imageUrl,
                  height: 55,
                  width: 55,
                )),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                product.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Icon(Icons.remove_circle_outline),
                  onTap: () {
                    cart.removeFromCart(product);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${product.quantity.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Icon(Icons.add_circle_outline),
                  onTap: () {
                    cart.addToCart(product);
                  },
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TOTAL'),
                Text(
                  '${(product.price * product.quantity).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              ],
            )),
      ),
    );
  }
}
