import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:my_shop/data/dummy_data.dart';
import 'package:my_shop/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products  = DUMMY_PRODUCTS;

   bool _showFavorite = false;
   
   int get getLenght => _products.length;

  List<Product> get products{
    if(_showFavorite){
     return _products.where((element) => element.isFavorite).toList();
    }else {
     return [..._products];
    }
  }

  bool get showFavorite => _showFavorite;

 void setOnlyFavorites(bool value){
    _showFavorite = value;
    notifyListeners();
  }

  

  void updateProduct(Product product){
    if(product == null && product.id == null){
      return;
    }
   final index = _products.indexWhere((element) => element.id == product.id);
   if(index >=0){
     print('update');
     _products[index] = product;
     notifyListeners();
   }
  }

  void addProduct(Product product){
    if(product.id == null){
      print('oi');
      product.id = Random().nextDouble().toString();
       _products.add(product);
    }
    notifyListeners();
  }
  void removeProduct(Product product){
    _products.remove(product);
    notifyListeners();
  }

  
}