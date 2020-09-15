import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:my_shop/models/product.dart';

class Products with ChangeNotifier {
  final _baseUrl = 'https://my-shop-30659.firebaseio.com/products';
  List<Product> _products = [];
  String _token;
  String _userId;

  Products(this._products, this._userId, this._token);
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

  Future<bool> updateProduct(Product product) async {
    if (product == null && product.id == null) {
      return false;
    }
    final index = _products.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      try {
        final response =
            await http.patch("$_baseUrl/${product.id}.json?auth=$_token",
                body: json.encode({
                  'imageUrl': product.imageUrl,
                  'title': product.title,
                  'price': product.price,
                  'description': product.description
                }));

        if (response.statusCode >= 400) {
          return false;
        }
        _products[index] = product;
        notifyListeners();
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Future<void> loadProducts() async {
    try {
      final response = await http.get("$_baseUrl.json?auth=$_token");
      final favResponse = await http.get(
          "https://my-shop-30659.firebaseio.com/userFavorites/$_userId.json?auth=$_token");
      final data = json.decode(response.body);
      final favMap = json.decode(favResponse.body);
      
      if (data != null) {
        _products.clear();
        data.forEach((id, product) {
          bool isFav = favMap == null ? false : favMap[id] ?? false;
          print(isFav);
          _products.add(Product(
              id: id,
              imageUrl: product['imageUrl'],
              title: product['title'],
              price: product['price'],
              description: product['description'],
              isFavorite: isFav));
        });
        notifyListeners();
      }

      return Future.value();
    } catch (e) {
      throw Error();
    }
  }

  Future<bool> addProduct(Product product) async {
    return http
        .post("$_baseUrl.json?auth=$_token",
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavorite': product.isFavorite
            }))
        .then((response) {
      final body = json.decode(response.body);

      if (body['error'] != null) {
        throw Error;
      }

      product.id = body['name'];

      _products.add(product);

      notifyListeners();
      return true;
    }).catchError((error) => false);
  }

  Future<void> removeProduct(String id) async {
    final index = _products.indexWhere((element) => element.id == id);
    if (index >= 0) {
      final product = _products[index];
      _products.remove(product);
      notifyListeners();

      try {
        final response =
            await http.delete("$_baseUrl/${product.id}.json?auth=$_token");

        if (response.statusCode >= 400) {
          throw ('Você não tem permissão para deletar um produto');
        }
      } catch (e) {
        _products.insert(index, product);
        notifyListeners();
        if (e == 'Você não tem permissão para deletar um produto') {
          throw ('Você não tem permissão para deletar um produto');
        }
        throw ('Verifique sua conexão com a internet');
      }
    }
  }
}
