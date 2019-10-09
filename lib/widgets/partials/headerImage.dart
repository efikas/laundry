import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(75.0)),
          boxShadow: [
            BoxShadow(blurRadius: 7.0, color: Colors.white30, spreadRadius: 2.0)
          ]
      ),
      child: ClipRRect(
          borderRadius: new BorderRadius.circular(75.0),
          child: Image.asset("assets/images/logo.png", width: 100.0, ),
      ),
    );
  }
}