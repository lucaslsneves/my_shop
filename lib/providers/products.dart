import 'package:flutter/foundation.dart';
import 'package:my_shop/data/dummy_data.dart';
import 'package:my_shop/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products  = DUMMY_PRODUCTS;

  List<Product> get products => [..._products];



  void addProduct(Product product){
    _products.add(product);
    notifyListeners();
  }
  void removeProduct(Product product){
    _products.remove(product);
    notifyListeners();
  }
}