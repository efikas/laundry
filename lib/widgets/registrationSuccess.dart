import 'package:flutter/material.dart';
import 'package:laundry/widgets/login.dart';
import 'package:laundry/widgets/register.dart';

class RegistrationSuccess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     TextStyle myStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);

    final headerImage = Container(
                  width: 100.0,
                  height: 100.0,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.white30, spreadRadius: 2.0)
                      ]
                  ),
                  child: ClipRRect(
                      borderRadius: new BorderRadius.circular(75.0),
                      child: Image.asset("assets/images/logo.png", width: 100.0, ),
                  ),
                );

    final signUp = InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => Register()));
      },
      child: Text("Sign Up",
        textAlign: TextAlign.center,
        style: myStyle.copyWith(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final signIn = InkWell(
      onTap: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => Login()));
      },
      child: Container(
        width: 300.0,
        height: 50.0,
        decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white, width: 2.0),
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: new Center(child: new Text('Proceed to Sign In', style: new TextStyle(fontSize: 18.0, color: Colors.white),),),
      ),
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
                        SizedBox(height: 150.0),
                        headerImage,
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
                        SizedBox(height: 35.0,),
                        signIn
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