import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:my_shop/models/product.dart';

class Products with ChangeNotifier {
  final _url = 'https://my-shop-30659.firebaseio.com/products.json';
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

  void updateProduct(Product product) {
    if (product == null && product.id == null) {
      return;
    }
    final index = _products.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      print('update');
      _products[index] = product;
      notifyListeners();
    }
  }

  Future<void> loadProducts() async {
    final response = await http.get(_url);

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
        .post(_url,
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

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }
}
