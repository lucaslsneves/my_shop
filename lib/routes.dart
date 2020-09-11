import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/views/auth_page.dart';
import 'package:my_shop/views/cart_page.dart';
import 'package:my_shop/views/orders_page.dart';
import 'package:my_shop/views/product_detail.dart';
import 'package:my_shop/views/product_form_page.dart';
import 'package:my_shop/views/products_list_page.dart';
import 'package:my_shop/views/products_page.dart';

class Routes {
  static const String AUTH = '/';
  static const String HOME = '/home';
  static const String PRODUCTS = '/products';
  static const String PRODUCTS_FORM = '/products_form';
  static const String PRODUCT_DETAIL = '/product_detail';
  static const String CART = '/cart';
  static const String ORDERS = '/orders';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AUTH:
        return MaterialPageRoute(builder: (context) => AuthPage());
      case HOME:
        return MaterialPageRoute(builder: (context) => ProductsListPage());
      case PRODUCT_DETAIL:
        return MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: args));
      case CART:
        return MaterialPageRoute(builder: (context) => CartPage());
      case ORDERS:
        return MaterialPageRoute(builder: (context) => OrdersPage());
      case PRODUCTS:
        return MaterialPageRoute(builder: (context) => ProductsPage());
      case PRODUCTS_FORM:
        return MaterialPageRoute(builder: (context) => ProductFormPage(product: args,));
      default:
        return MaterialPageRoute(builder: (context) => ProductsListPage());
    }
  }
}
