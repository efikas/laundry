import 'package:animator/animator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:laundry/models/ServiceModel.dart';
import 'package:laundry/widgets/partials/addressForm.dart';
import 'package:laundry/widgets/pickupRequestSuccess.dart';
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
  bool _isLoading = false;

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

    final animateRegisterButton = Animator(
        duration: Duration(milliseconds: 300),
        cycles: 1,
        builder: (anim) => Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.blue,
          child: MaterialButton(
            onPressed: () {
              _submit();
            },
            minWidth: _buttonAnimate(anim.value),
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: _buttonLabel(anim.value ),
          ),
        ),
    );

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
            animateRegisterButton
          ],
        ),
      );
  }

  double _buttonAnimate(double tween) {

    if(_isLoading){
      return MediaQuery.of(context).size.width - ((MediaQuery.of(context).size.width - 100) * tween);
    }
    else if(_isLoading){
      return 150 + ((MediaQuery.of(context).size.width - 150) * tween);
    }
    else {
        return (MediaQuery.of(context).size.width - 100);
    }
  }

  Widget _buttonLabel(double tween) {

    if(_isLoading && serviceState.isLoading && tween > 0.5){
      return Container(
        width: 20,
        height: 20.0,
        child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 2,),
      );
    }
    else if(_isLoading && !serviceState.isLoading && tween > 0.5){
      return Text("Request",
          textAlign: TextAlign.center,
          style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
      );
    }
    else {
      return Text("Request",
          textAlign: TextAlign.center,
          style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
      );
    }
  }

  void _submit() async{

    if(!serviceState.isLoading) {
      setState(() {_isLoading = true;});

      try{
        Map<dynamic, dynamic> response = await serviceState.sendPickupRequest();

        print(response);
          if(response != null && response.containsKey("id")) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => PickUpRequestSuccess()));
          }
          else {
            Flushbar(
              message: "There was a problem connecting to the server, check your internet connection!",
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.red[300],
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.red[300],
              flushbarPosition: FlushbarPosition.TOP,
            )..show(context);
          }
          setState(() {_isLoading = false;});
      }
        catch (error) {
          print(error);
          Flushbar(
            message: "Network Error, Check your internet connection.!",
            icon: Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.red[300],
            ),
            duration: Duration(seconds: 3),
            leftBarIndicatorColor: Colors.red[300],
            flushbarPosition: FlushbarPosition.TOP,
          )..show(context);
          setState(() {_isLoading = false;});
        }
    }
  }
}
