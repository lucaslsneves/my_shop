import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  double quantity;
  final String imageUrl;
  bool isFavorite = false;

  

  Product({
    @required this.id,
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
