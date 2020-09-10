import 'package:flutter/material.dart';
import 'package:my_shop/components/app_drawer.dart';
import 'package:my_shop/components/order_item.dart';
import 'package:my_shop/models/order.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Orders>(context, listen: false).loadOrders().then((value) => 
      setState(() {
        _isLoading = false;
      })
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Orders'),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => orders.loadOrders(),
                          child: LayoutBuilder(
                  builder: (ctx, constrains) => Container(
                    height: constrains.maxHeight,
                    child: ListView.builder(
                        itemCount: orders.orders.length,
                        itemBuilder: (ctx, i) {
                          return OrderItem(orders.orders[i]);
                        }),
                  ),
                ),
            ));
  }
}
