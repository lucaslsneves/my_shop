import 'package:flutter/material.dart';
import 'package:my_shop/components/app_drawer.dart';
import 'package:my_shop/models/order.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Orders'),),
      body: LayoutBuilder(
              builder: (ctx,constrains) => Container(
                height: constrains.maxHeight,
                child: ListView.builder(itemCount: orders.orders.length,itemBuilder: (ctx,i) {
          return ListTile(title: Text(orders.orders[i].id),);
        }),
              ),
      )
    );
  }
}