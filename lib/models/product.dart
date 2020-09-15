import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final _baseUrl = 'https://my-shop-30659.firebaseio.com';
  String id;
  String title;
  String description;
  double price;
  double quantity;
  String imageUrl;
  bool isFavorite = false;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.quantity = 0,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      id: json['id'],
      description:  json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      title: json['title'],
      quantity: json['quantity']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = this.id;
    json['title'] = this.title;
    json['description'] = this.description;
    json['price'] = this.price;
    json['imageUrl'] = this.imageUrl;
    json['quantity'] = this.quantity;
    return json;
  }

  toogleFavorite(String token,String userId) async {
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.put("$_baseUrl/userFavorites/$userId/$id.json?auth=$token",
          body: json.encode(isFavorite));
      
      if (response.statusCode >= 400) {
        throw Error;
      }
    } catch (e) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw Error;
    }
  }
}
