import 'dart:async';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:laundry/models/Service.dart';
import 'package:provider/provider.dart';
import 'package:laundry/store/serviceState.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundry/widgets/partials/headerImage.dart';
import 'package:laundry/widgets/partials/requestCard.dart';


class PickupRequest extends StatefulWidget {
  @override
  _PickupRequest createState() => _PickupRequest();
}

class _PickupRequest extends State<PickupRequest> {
  bool _isLoading = false;
  dynamic serviceState;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }


  increment(String key) =>(){
    serviceState.increment(key);
  };

  itemInCart(){
    int _total = 0;
    serviceState.getServices.values.toList().forEach((Service service){
      _total += service.quantity;
    });
    
    return _total.toString();
  }

  totalNumberitemInCart(){
    int _totalPrice = 0;
    serviceState.getServices.values.toList().forEach((Service service){
      _totalPrice += service.quantity * int.parse(service.price);
    });
    
    return _totalPrice.toString();
  }

  decrement(String key) =>(){
    serviceState.decrement(key);
  };

  @override
  Widget build(BuildContext context) {
    serviceState = Provider.of<ServiceState>(context);

    final nextButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.blueAccent,
        child: MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/addressPage');;
          },
          minWidth: 150.0,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text("Next",
              textAlign: TextAlign.center,
              style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
          ),
        ),
      );

    return Scaffold(
      appBar: AppBar(
        title: Text("Pickup Request"),
      ),
      body: Column(
          children: <Widget>[
            Container(
              height: 160.0,
              child: Stack(
                children: <Widget>[
                  new Container(
                    height: 160,
                    color: Colors.blue,
                  ),

                  Positioned(
                    top: 0.0,
                    //position the container at the middle of the wall and 
                    //the headerImage
                    right: ((MediaQuery.of(context).size.width / 2) - 50 - 100) / 2,
                    child: Container(
                      width: 100,
                      height: 150,
                      padding: EdgeInsets.symmetric(vertical: 40),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.moneyBill, color: Colors.white70,),
                          Text("#" + totalNumberitemInCart(), style: TextStyle(
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
                      height: 150,
                      padding: EdgeInsets.symmetric(vertical: 40),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.shoppingBasket, color: Colors.white70,),
                          Text(itemInCart(), style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            color: Colors.white,
                            fontSize: 20
                            ),)
                        ],
                      ),
                    ),
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
                ],
              ),
            ),

            Container(padding: EdgeInsets.only(bottom: 10),
              height: MediaQuery.of(context).size.height - 320,
              child: ListView.builder(
                itemCount: serviceState.getServices.values.toList().length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return RequestCard(
                    imageUrl: serviceState.getServices.values.toList()[index].image,
                    price: serviceState.getServices.values.toList()[index].price,
                    slug: serviceState.getServices.values.toList()[index].slug,
                    quantity: serviceState.getServices.values.toList()[index].quantity.toString(),
                    increment: increment(serviceState.getServices.values.toList()[index].key),
                    decrement: decrement(serviceState.getServices.values.toList()[index].key),
                  );
                }
              ),
            ),

            nextButton
          ],
        ),
      );
  }

}