import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color color;

  Badge({
  @required this.child,
  @required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(right: 4,top:4,child:Container(padding: EdgeInsets.all(4),decoration: BoxDecoration(shape: BoxShape.circle,color: color ?? Theme.of(context).accentColor),child: Text(value,style: TextStyle(fontSize: 15),)),)
      ],
    );
  }
}
