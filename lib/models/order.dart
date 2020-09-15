import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:my_shop/models/product.dart';

class Order {
  String id;
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
  final _baseUrl = 'https://my-shop-30659.firebaseio.com/orders';
  String _token;
  String _userId;

  List<Order> _orders = [];

  Orders(this._token,this._userId,this._orders );

  List<Order> get orders => [..._orders];

Future<bool> loadOrders() async {
  try {
    final response = await http.get("$_baseUrl/$_userId.json?auth=$_token");
    final resp = json.decode(response.body) as Map;
    _orders.clear();
    if(resp != null) {
        resp.forEach((id, order) {
      _orders.add(Order(
        id: id,
        amount: order['amount'],
        date: DateTime.parse(order['date']),
        items: order['items'].map<Product>((e) => Product.fromJson(e)).toList()
      ));
    });
     if(response.statusCode >= 400){
      throw Error;   
    }
  
    // Ordenando a lista (pedidos mais recentes primeiro)
    _orders = _orders.reversed.toList();
      notifyListeners();
    }
  return true;
  }catch(e){
    print(e);
    return false;
  }
}

 Future<void> addOrder(Order order) async{
    
    

    try {
      final response = await http.post("$_baseUrl/$_userId.json?auth=$_token",body: json.encode({
        'amount' : order.amount,
        'date' : order.date.toIso8601String(),
        'items' : order.items.map((e) => e.toJson()).toList(),
      }));
      order.items = order.items.map((item) => Product(
      id : json.decode(response.body)['name'],
      description: item.description,
      imageUrl: item.imageUrl,
      price: item.price,
      title: item.title,
      quantity: item.quantity,
      isFavorite: item.isFavorite
    )).toList();
    _orders.add(order);
      if(response.statusCode >= 400){
        throw Error;
      }
    }catch(e){
      print(e);
       _orders.remove(order);
        notifyListeners();
        throw Error;
    }
  }
}