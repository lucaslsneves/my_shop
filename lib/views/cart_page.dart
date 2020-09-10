import 'package:flutter/material.dart';
import 'package:my_shop/components/cart_item.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/models/order.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: cart.getCartLength == 0
            ? Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 40,
                  ),
                  Text(
                    'Carrinho está vazio',
                    style: TextStyle(fontSize: 25, color: Colors.purple),
                  )
                ]),
              )
            : _isLoading == false
                ? LayoutBuilder(
                    builder: (ctx, constrains) => Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: constrains.biggest.height - 100,
                          child: ListView.builder(
                              itemCount: cart.items.length,
                              itemBuilder: (ctx, i) {
                                return CartItem(cart.items[i]);
                              }),
                        ),
                        Container(
                          width: constrains.maxWidth - 20,
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Chip(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        label: Text(
                                          cart.totalFormatted,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  LayoutBuilder(
                                    builder: (ctx, _) => FlatButton(
                                      child: Text(
                                        'Finalizar',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      onPressed: () async {
                                        
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        try {
                                          await orders.addOrder(Order(
                                            amount: cart.total,
                                            items: cart.items,
                                            date: DateTime.now(),
                                          ));

                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  Routes.ORDERS);
                                          cart.clearCart();
                                          _isLoading = false;
                                        } catch (e) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Scaffold.of(ctx)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Erro ao finalizar compra'),
                                          ));
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
