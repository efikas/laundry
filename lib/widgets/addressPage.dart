import 'package:flutter/material.dart';
import 'package:laundry/models/ServiceModel.dart';
import 'package:laundry/widgets/partials/addressForm.dart';
import 'package:provider/provider.dart';
import 'package:laundry/store/serviceState.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundry/widgets/partials/headerImage.dart';


class AddressPage extends StatefulWidget {
  @override
  _AddressPage createState() => _AddressPage();
}

class _AddressPage extends State<AddressPage> {
  dynamic serviceState;

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
    serviceState = Provider.of<ServiceState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pickup Form"),
      ),
      body: Column(
          children: <Widget>[
            Container(
              height: 160.0,
              child: Stack(
                children: <Widget>[
                  new Container(
                    height: 120,
                    color: Colors.blue,
                  ),

                  Positioned(
                    top: 0.0,
                    //position the container at the middle of the wall and 
                    //the headerImage
                    right: ((MediaQuery.of(context).size.width / 2) - 50 - 100) / 2,
                    child: Container(
                      width: 100,
                      height: 110,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.moneyBill, color: Colors.white70,),
                          Text("₦" + serviceState.priceOfItemsInCart, style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            color: Colors.white,
                            fontSize: 16
                            )
                          )
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0.0,
                    //position the container at the middle of the wall and 
                    //the headerImage
                    left: ((MediaQuery.of(context).size.width / 2) - 50 - 80) / 2,
                    child: Container(
                      width: 80,
                      height: 100,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.shoppingBasket, color: Colors.white70,),
                          Text(serviceState.itemInCart, style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            color: Colors.white,
                            fontSize: 20
                            ),)
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: HeaderImage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(padding: EdgeInsets.only(bottom: 10),
              height: MediaQuery.of(context).size.height - 320,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AddressForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
