import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laundry/widgets/partials/headerImage.dart';
import 'package:laundry/widgets/partials/servicesCard.dart';


class Pickups extends StatefulWidget {
  Function switchPage;

  @override
  _PickupsState createState() => _PickupsState();
}

class _PickupsState extends State<Pickups> {
  
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
            height: 1000.0, //calculate height 
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
                    // height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ServicesCard(imageUrl:"assets/images/wash_fold.jpg", slug:"Wash & Fold"),
                        ServicesCard(imageUrl:"assets/images/wash_iron.jpg", slug:"Wash & Iron"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ServicesCard(imageUrl:"assets/images/wash_fold.jpg", slug:"Wash & Fold"),
                        ServicesCard(imageUrl:"assets/images/wash_iron.jpg", slug:"Wash & Iron"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ServicesCard(imageUrl:"assets/images/wash_fold.jpg", slug:"Wash & Fold"),
                        ServicesCard(imageUrl:"assets/images/wash_iron.jpg", slug:"Wash & Iron"),
                      ],
                    ),
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}