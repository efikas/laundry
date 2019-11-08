import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundry/models/UserModel.dart';
import 'package:provider/provider.dart';
import 'package:laundry/store/userState.dart';
import 'package:laundry/store/serviceState.dart';

class AddressForm extends StatefulWidget {
  AddressForm({Key key}) : super(key: key);

  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  TextStyle myStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.blueAccent);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  double containerWidth = 120.0;
  double _opacity = 0.0;
  dynamic userState;
  dynamic serviceState;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 300), () {
      setState(() {
        containerWidth = (MediaQuery.of(context).size.width > 400) ? 200 : (MediaQuery.of(context).size.width - 40) / 2;
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    userState = Provider.of<UserState>(context);
    serviceState = Provider.of<ServiceState>(context);
    User userInfo = userState.getUserInfoModel;
    //populate pickupInfo with user info
    serviceState.pickUpInfo = {
      "fullname": userInfo.fullname,
      "address": userInfo.address,
      "phone": userInfo.phone,
    };

    final fullnameField = TextFormField(
        style: myStyle,
        initialValue: serviceState.pickUpInfo["fullname"],
        cursorColor: Colors.blueAccent,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Username",
            labelText: 'Fullname',
            labelStyle: TextStyle(color: Colors.blueAccent),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: new BorderSide(color: Colors.blueAccent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.blueAccent.shade700),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.blueAccent.shade100,)
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.red)
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.redAccent)
            ),
        ),
        validator: _validateFullname,
        onChanged: (String val) {
          //update pickipinfo in the store
          serviceState.pickUpInfo = {
            ...serviceState.pickUpInfo,
            "fullname": val
          };

          return serviceState.pickUpInfo["fullname"];
        },
    );

    final phoneField = TextFormField(
        style: myStyle,
        initialValue: serviceState.pickUpInfo["phone"],
        cursorColor: Colors.blueAccent,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Username",
            labelText: 'Mobile Number',
            labelStyle: TextStyle(color: Colors.blueAccent),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: new BorderSide(color: Colors.blueAccent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.blueAccent.shade700),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.blueAccent.shade100),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.red)
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.redAccent)
            ),
        ),
        validator: _validatePhone,
        onChanged: (String val) {
          //update pickipinfo in the store
          serviceState.pickUpInfo = {
            ...serviceState.pickUpInfo,
            "phone": val
          };

          return serviceState.pickUpInfo["phone"];
        },
    );
                
    final addressField = TextFormField(
        style: myStyle,
        initialValue: serviceState.pickUpInfo["address"],
        cursorColor: Colors.blueAccent,
        keyboardType: TextInputType.multiline,
        maxLength: null,
        maxLines: null,
        minLines: 5,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Address",
            labelText: 'Home Address', 
            hasFloatingPlaceholder: true,
            labelStyle: TextStyle(color: Colors.blueAccent),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: new BorderSide(color: Colors.blueAccent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.blueAccent.shade700),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.blueAccent.shade100),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.red)
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.redAccent)
            ),
        ),
        validator: _validateAddress,
        onChanged: (String val) {
          //update pickipinfo in the store
          serviceState.pickUpInfo = {
            ...serviceState.pickUpInfo,
            "address": val
          };

          return serviceState.pickUpInfo["address"];
        },
    );


    return Container(
       child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    fullnameField,
                    SizedBox(height: 25.0,),
                    phoneField,
                    SizedBox(height: 25.0,),
                    addressField,
                    SizedBox(height: 30.0,),
                  ],
                ),
              ),
              SizedBox(height: 70.0,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     AnimatedContainer(
              //       duration:Duration(milliseconds: 500),
              //       width: containerWidth,
              //       height: 80.0,
              //       padding: EdgeInsets.only(top: 12.0, left: 10.0),
              //       decoration: BoxDecoration(
              //         color: Colors.blue,
              //         borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
              //       ),
              //       child: ListTile(
              //         leading: Icon(FontAwesomeIcons.moneyBill, color: Colors.white60,),
              //         title: AnimatedOpacity(
              //           opacity: _opacity,
              //           duration: Duration(seconds: 3),
              //           child: Text("Pay On Delivery", 
              //               style: TextStyle(color: Colors.white, fontSize: 14.0), 
              //               overflow: TextOverflow.clip,
              //               ),
              //         ),
              //         onTap: (){
              //           serviceState.sendPickupRequest();
              //         },
              //       )
              //     ),
              //     AnimatedContainer(
              //       duration:Duration(milliseconds: 500),
              //       width: containerWidth,
              //       height: 80.0,
              //       padding: EdgeInsets.only(top: 12.0, left: 10.0),
              //       decoration: BoxDecoration(
              //         color: Colors.blue,
              //         borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
              //       ),
              //       child: ListTile(
              //         leading: Icon(Icons.credit_card, color: Colors.white60,),
              //         title: AnimatedOpacity(
              //           opacity: _opacity,
              //           duration: Duration(seconds: 3),
              //           child: Text("Make Payment", style: TextStyle(color: Colors.white), overflow: TextOverflow.clip, ),
              //         ),
              //         onTap: (){
              //           Navigator.of(context).pushNamed('/makePaymentPage');
              //         },
              //       )
              //     ),
              //   ],
              // )
            ],
          ),
        ),
    );
  }


  String _validateFullname(String value) {
    if (value.trim().length < 1) return 'Fullname can not be empty';

    return null;
  }

  String _validateAddress(String value) {
    if (value.trim().length < 1) return 'Address can not be empty';

    return null;
  }

  String _validatePhone(String value) {
    if (value.trim().length < 1) return 'Phone can not be empty';

    return null;
  }

}
