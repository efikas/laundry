import 'package:flutter/material.dart';
import 'package:laundry/store/serviceState.dart';
import 'package:laundry/widgets/partials/headerImage.dart';
import 'package:provider/provider.dart';

class PickUpRequestSuccess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final serviceState = Provider.of<ServiceState>(context);
    TextStyle myStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);

    final btn = InkWell(
      onTap: (){
        //reset the services 
        serviceState.resetServices();
        
        Navigator.of(context).pop();
      },
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white, 
        ),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Container(
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.blueAccent, 
            ),
            child: Center(
              child: Text("Back", style: TextStyle(color: Colors.white),),
            ),
          ),
        )
      )
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/laundry1.jpg"), fit: BoxFit.cover,),
            ),
          ),
          Container(
            color: Color.fromRGBO(27, 161, 226, 0.8),
          ),
          Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 100.0),
                        HeaderImage(),
                        SizedBox(height: 100.0),
                        Icon(Icons.check_circle_outline, color: Colors.green, size: 120.0,),
                        SizedBox(height: 30.0),
                        Text("Thank You For",
                          textAlign: TextAlign.center,
                          style: myStyle.copyWith(
                            color: Colors.greenAccent,
                            fontSize: 25.0
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text("Registration",
                          textAlign: TextAlign.center,
                          style: myStyle.copyWith(
                            color: Colors.greenAccent,
                            fontSize: 25.0
                          ),
                        ),
                        SizedBox(height: 40.0),
                        btn,
                      ],
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }

}