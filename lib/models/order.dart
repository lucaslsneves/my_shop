import 'package:flutter/foundation.dart';
import 'package:my_shop/models/product.dart';

class Order {
  final String id;
  final double amount;
  final List<Product> items;
  final DateTime date;

  Order({
    this.id,
    this.amount,
    this.items,
    this.date
  });

}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  addOrder(Order order){
    _orders.add(order);
    notifyListeners();
  }
}