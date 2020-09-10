import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:my_shop/models/product.dart';

class Products with ChangeNotifier {
  final _baseUrl = 'https://my-shop-30659.firebaseio.com/products';
  List<Product> _products = [];

  bool _showFavorite = false;

  int get getLenght => _products.length;

  List<Product> get products {
    if (_showFavorite) {
      return _products.where((element) => element.isFavorite).toList();
    } else {
      return [..._products];
    }
  }

  bool get showFavorite => _showFavorite;

  void setOnlyFavorites(bool value) {
    _showFavorite = value;
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    if (product == null && product.id == null) {
      return;
    }
    final index = _products.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      await http.patch("$_baseUrl/${product.id}.json",
          body: json.encode({
            'imageUrl': product.imageUrl,
            'title': product.title,
            'price': product.price,
            'description': product.description
          }));
      _products[index] = product;
      notifyListeners();
    }
  }

  Future<void> loadProducts() async {
    final response = await http.get("$_baseUrl.json");

    final data = json.decode(response.body);
    if (data != null) {
      _products.clear();
      data.forEach((id, product) {
        _products.add(Product(
            id: id,
            imageUrl: product['imageUrl'],
            title: product['title'],
            price: product['price'],
            description: product['description']));
      });
      notifyListeners();
    }

    return Future.value();
  }

  Future<bool> addProduct(Product product) async {
    return http
        .post("$_baseUrl.json",
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavorite': product.isFavorite
            }))
        .then((response) {
      final body = json.decode(response.body);
      product.id = body['name'];

      _products.add(product);

      notifyListeners();
      return true;
    }).catchError((error) => false);
  }

  Future<void> removeProduct(String id) async {
    final index = _products.indexWhere((element) => element.id == id);
    if(index >=0){
      final product = _products[index];
       _products.remove(product);
         notifyListeners();


    final response = await http.delete("$_baseUrl/${product.id}");

    
    if(response.statusCode >= 400){
      print(response.statusCode);
      _products.insert(index, product);
      notifyListeners();
     throw Error;
    }
   
    }
    
  }
}
