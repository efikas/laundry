import 'dart:async';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:laundry/models/ServiceModel.dart';
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


    Timer(Duration(seconds: 2), (){
        serviceState.checkforServicesPriceChange();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  increment(String category, String key) =>(){
    serviceState.increment(category, key);
  };

  decrement(String category, String key) =>(){
    serviceState.decrement(category, key);
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
              height: 80.0,
              child: Stack(
                children: <Widget>[
                  new Container(
                    height: 80,
                    color: Colors.blue,
                  ),

                  Positioned(
                    top: 0.0,
                    //position the container at the middle of the wall and 
                    //the headerImage
                    right: ((MediaQuery.of(context).size.width / 2) - 50 - 100) / 2,
                    child: Container(
                      width: 100,
                      height: 80,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
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
                      height: 80,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
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
                    top: 5.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: HeaderImage(size: 70.0,),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(padding: EdgeInsets.only(bottom: 10),
              height: MediaQuery.of(context).size.height - 240,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.blue,
                      child: TabBar(
                        indicatorColor: Colors.white,
                        tabs: [
                          Tab(icon: Icon(FontAwesomeIcons.male, size: 18.0,), text: "Men",),
                          Tab(icon: Icon(FontAwesomeIcons.female, size: 18.0,), text: "Women",),
                          Tab(icon: Icon(FontAwesomeIcons.bed, size: 18.0,), text: "Others",),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TabBarView(
                        children: [
                          _men(),
                          _women(),
                          _others(),
                        ],
                      ),
                    )
                  ],
                )
              ),
              
            ),

            nextButton
          ],
        ),
      );
  }


  Widget _men() {
    return ListView.builder(
      itemCount: serviceState.getServices["men"].values.toList().length,
      itemBuilder: (BuildContext ctxt, int index) {
        return RequestCard(
          imageUrl: serviceState.getServices["men"].values.toList()[index].image,
          price: serviceState.getServices["men"].values.toList()[index].price,
          slug: serviceState.getServices["men"].values.toList()[index].name,
          quantity: serviceState.getServices["men"].values.toList()[index].quantity.toString(),
          increment: increment("men", serviceState.getServices["men"].values.toList()[index].slug),
          decrement: decrement("men", serviceState.getServices["men"].values.toList()[index].slug),
        );
      }
    );
  }

  Widget _women() {
    return ListView.builder(
      itemCount: serviceState.getServices["women"].values.toList().length,
      itemBuilder: (BuildContext ctxt, int index) {
        return RequestCard(
          imageUrl: serviceState.getServices["women"].values.toList()[index].image,
          price: serviceState.getServices["women"].values.toList()[index].price,
          slug: serviceState.getServices["women"].values.toList()[index].name,
          quantity: serviceState.getServices["women"].values.toList()[index].quantity.toString(),
          increment: increment("women", serviceState.getServices["women"].values.toList()[index].slug),
          decrement: decrement("women", serviceState.getServices["women"].values.toList()[index].slug),
        );
      }
    );
  }

  Widget _others() {
    return ListView.builder(
      itemCount: serviceState.getServices["others"].values.toList().length,
      itemBuilder: (BuildContext ctxt, int index) {
        return RequestCard(
          imageUrl: serviceState.getServices["others"].values.toList()[index].image,
          price: serviceState.getServices["others"].values.toList()[index].price,
          slug: serviceState.getServices["others"].values.toList()[index].name,
          quantity: serviceState.getServices["others"].values.toList()[index].quantity.toString(),
          increment: increment("others", serviceState.getServices["others"].values.toList()[index].slug),
          decrement: decrement("others", serviceState.getServices["others"].values.toList()[index].slug),
        );
      }
    );
  }

}