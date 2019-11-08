import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundry/widgets/pickup_request.dart';
import 'package:laundry/widgets/partials/headerImage.dart';
import 'package:laundry/widgets/partials/servicesCard.dart';


class Services extends StatefulWidget {
  
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
            height: 300.0,
            child: Stack(
              children: <Widget>[
                new Container(
                  height: 200,
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
                  top: 125.0,
                  // bottom: 50,
                  child: new Container(
                    height: 150,
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
            height: 280,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ServicesCard(imageUrl: "assets/images/drying_clothes.jpg", slug: "Drying Clothes"),
                    ServicesCard(imageUrl: "assets/images/dry_clean.jpeg", slug: "Dry Clean"),
                  ],
                ),
                SizedBox(height: 40.0,),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.blue,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => PickupRequest())
                      );
                    },
                    minWidth: 200.0,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20.0,),
                          Icon(FontAwesomeIcons.truckPickup, color: Colors.white54,),
                          SizedBox(width: 10.0,),
                          Text("Pickup Request",
                              textAlign: TextAlign.center,
                              style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
                          ),
                        ],
                      ),
                    ),
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