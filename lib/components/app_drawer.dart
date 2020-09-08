import 'package:flutter/material.dart';
import 'package:my_shop/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: Column(children: [
        AppBar(automaticallyImplyLeading: false,title: Text('Bem vindo usuário'),),
        Divider(),
        ListTile(leading: Icon(Icons.shop),title: Text('Produtos'),onTap: () {
          Navigator.of(context).pushReplacementNamed(Routes.HOME);
        },),
        Divider(),
        ListTile(leading: Icon(Icons.list),title: Text('Pedidos'),onTap: () {
          Navigator.of(context).pushReplacementNamed(Routes.ORDERS);
        },),
        Divider(),
        ListTile(leading: Icon(Icons.edit),title: Text('Gerenciar Produtos'),onTap: () {
          Navigator.of(context).pushReplacementNamed(Routes.PRODUCTS);
        },),
      ],),
    );
  }
}