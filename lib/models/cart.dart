import 'package:flutter/foundation.dart';
import 'package:my_shop/models/product.dart';

class Cart with ChangeNotifier {
  List<Product> items = [];

  int get getCartAmout => items.length;

  double _total = 0;

  double get total => _total; 
  String get totalFormatted => 'R\$ ${_total.toStringAsFixed(2)}';

  addToCart(Product product){
    
    if(product.quantity == 0){
      items.add(product);
      product.quantity++;
      _total+= product.price;
    }else {
      product.quantity++;
      _total+= product.price;
    }
    notifyListeners();
  }

  removeFromCart(Product product){
    if(product.quantity == 1){
      return;
    }
    product.quantity--;
    _total-= product.price;
    notifyListeners();
  }

  removeAllFromCart(Product product){
    items.remove(product);
    _total -= product.price * product.quantity;
    product.quantity = 0;
    notifyListeners();
  }
  
  
}