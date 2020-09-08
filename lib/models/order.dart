import 'package:flutter/foundation.dart';
import 'package:my_shop/models/product.dart';

class Order {
  final String id;
  final double amount;
  List<Product> items;
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
    order.items = order.items.map((item) => Product(
      id: item.id,
      description: item.description,
      imageUrl: item.imageUrl,
      price: item.price,
      title: item.title,
      quantity: item.quantity,
      isFavorite: item.isFavorite
    )).toList();
    _orders.add(order);
    notifyListeners();
  }
}