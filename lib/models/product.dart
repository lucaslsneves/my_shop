import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
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

  toogleFavorite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
