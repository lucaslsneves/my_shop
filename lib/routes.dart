import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/views/product_detail.dart';
import 'package:my_shop/views/products_list_page.dart';

class Routes {
 static const String HOME = '/'; 
 static const String PRODUCT_DETAIL = '/product_detail';

 static Route<dynamic> onGenerateRoute(RouteSettings settings){
   final args = settings.arguments;
    switch(settings.name){
      case HOME:
        return MaterialPageRoute(builder: (context) => ProductsListPage());
      case PRODUCT_DETAIL:
        return MaterialPageRoute(builder: (context) => ProductDetailPage(product:args));
      default:
        return MaterialPageRoute(builder: (context) => ProductsListPage());
    }
  }
}