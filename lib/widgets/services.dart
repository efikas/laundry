import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laundry/widgets/partials/headerImage.dart';
import 'package:laundry/widgets/partials/servicesCard.dart';


class Services extends StatefulWidget {
  Function switchPage;

  Services({
      Key key, 
      @required this.switchPage
    }): 
    assert(switchPage != null),
    super(key: key);

  @override
  _CustomLayoutExampleState createState() => _CustomLayoutExampleState();
}

class _CustomLayoutExampleState extends State<Services> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 350.0,
            child: Stack(
              children: <Widget>[
                new Container(
                  height: 250,
                  color: Colors.blue,
                ),
                Positioned(
                  top: 20.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: HeaderImage(),
                    ),
                  ),
                ),

                Positioned(
                  top: 175.0,
                  // bottom: 50,
                  child: new Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ServicesCard(imageUrl:"assets/images/wash_fold.jpg", slug:"Wash & Fold"),
                        ServicesCard(imageUrl:"assets/images/wash_iron.jpg", slug:"Wash & Iron"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 400.0,
            child: Column(
              children: <Widget>[
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ServicesCard(imageUrl: "assets/images/drying_clothes.jpg", slug: "Drying Clothes"),
                    ServicesCard(imageUrl: "assets/images/dry_clean.jpeg", slug: "Dry Clean"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}