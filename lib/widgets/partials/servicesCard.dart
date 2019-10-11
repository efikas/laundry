import 'dart:core';
import 'package:flutter/material.dart';

class ServicesCard extends StatelessWidget {
  String imageUrl, slug;

  ServicesCard({
      Key key, 
      @required this.imageUrl, 
      @required this.slug,
    }) : 
    assert(imageUrl != null),
    assert(slug != null),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      child: Card(
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: new BorderRadius.circular(35.0),
                child: Image.asset(imageUrl, width: 70.0, ),
              ),
              SizedBox(height: 10,),
              new Text(slug, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.4)),),
            ],
          ),
        ),
      ),
    );
  }
}