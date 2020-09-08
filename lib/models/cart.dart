import 'package:flutter/foundation.dart';
import 'package:my_shop/models/product.dart';

class Cart with ChangeNotifier {
  List<Product> _items = [];

  int get getCartAmout => _items.length;

  List<Product> get items => [..._items];

  double _total = 0;

  double get total => _total;
  String get totalFormatted => 'R\$ ${_total.toStringAsFixed(2)}';

  addToCart(Product product) {
    if (product.quantity == 0) {
      _items.add(product);
      product.quantity++;
    } else {
      product.quantity++;
    }
    _total += product.price;
    notifyListeners();
  }

  clearCart(){
    _items.forEach((element) {
      element.quantity = 0;
    });
    print(_items[0].quantity);
    _items = [];
    _total = 0;
    notifyListeners();
  }

  removeFromCartSnack(Product product){
    if(product.quantity == 1){
        _items.remove(product);   
        product.quantity = 0;
    }else {
      product.quantity--;
    }
     _total -= product.price;
     notifyListeners();
  }

  removeFromCart(Product product) {
    if (product.quantity == 1) {
      return;
    }
    product.quantity--;
    _total -= product.price;
    
  }

  removeAllFromCart(Product product) {
    _items.remove(product);
    _total -= product.price * product.quantity;
    product.quantity = 0;
    notifyListeners();
  }
}
