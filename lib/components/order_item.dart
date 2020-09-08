import 'package:flutter/material.dart';
import 'package:my_shop/models/order.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              title: Text(
                'R\$ ${widget.order.amount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 22),
              ),
              subtitle: Text(
                  '${DateFormat('dd MM yyyy hh:mm').format(widget.order.date)}'),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                ),
              ),
            ),
            if (_expanded)
              Container(
                height: 300,
                padding: const EdgeInsets.all(10),
                child: ListView(children: widget.order.items.map((product) {
                  return Column(
                    
                    children: [
                    Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                   
                      Row(
                        children: [
                          Text('${product.quantity.toStringAsFixed(0)} ',style: TextStyle(fontSize: 16),),
                           Text(product.title,style: TextStyle(fontSize: 20),),
                        ],
                      ),
                     Row(
                       children: [
                       
                         Text('R\$ ${product.price.toStringAsFixed(2)}',style: TextStyle(fontSize: 24))
                       ],
                     )
                    ],),
                    Divider(),
                  ],);
                }).toList(),),
              )
          ],
        ));
  }
}
