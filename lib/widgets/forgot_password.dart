import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:laundry/store/authState.dart';
import 'package:laundry/widgets/login.dart';



// Create a Form widget.
class ForgotPassword extends StatefulWidget {
  @override
  MyForgotPassword createState() {
    return MyForgotPassword();
  }
}



class MyForgotPassword extends State<ForgotPassword> {
  TextStyle myStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _autoValidate = false;
  String _email;

  @override
  Widget build(BuildContext context) {
    
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

     final emailField = TextFormField(
        style: myStyle,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Username",
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: new BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.white),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.white30),
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
        validator: _validateEmail,
        onSaved: (String val) => _email = val,
    );
    

    final animateLoginButton = Animator(
        duration: Duration(milliseconds: 300),
        cycles: 1,
        builder: (anim) => Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xff01A0C7),
          child: MaterialButton(
            onPressed: () {
              _validateInputsAndSubmit();
            },
            minWidth: _buttonAnimate(anim.value),
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: _buttonLabel(anim.value ),
          ),
        ),
    );

    final signIn = InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login())
        );
      },
      child: Text("Sign in",
        textAlign: TextAlign.center,
        style: myStyle.copyWith(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),
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
                        SizedBox(height: 50.0),
                        Text("Please enter your email",
                          textAlign: TextAlign.center,
                          style: myStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18.0
                          ),
                        ),
                        SizedBox(height: 25.0,),
                        emailField,
                        SizedBox(height: 25.0,),
                        animateLoginButton,
                        SizedBox(height: 35.0,),
                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("First time here? ",
                          textAlign: TextAlign.center,
                          style: myStyle.copyWith(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
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

double _buttonAnimate(double tween) {
    final authState = Provider.of<AuthState>(context);

    if(_isLoading && authState.isLoading){
      return MediaQuery.of(context).size.width - ((MediaQuery.of(context).size.width - 150) * tween);
    }
    else if(_isLoading && !authState.isLoading){
      return 150 + ((MediaQuery.of(context).size.width - 150) * tween);
    }
    else {
        return MediaQuery.of(context).size.width;
    }
  }

  Widget _buttonLabel(double tween) {
    final authState = Provider.of<AuthState>(context);

    if(_isLoading && authState.isLoading && tween > 0.5){
      return Container(
        width: 20,
        height: 20.0,
        child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 2,),
      );
    }
    else if(_isLoading && !authState.isLoading && tween > 0.5){
      return Text("Submit",
          textAlign: TextAlign.center,
          style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
      );
    }
    else {
      return Text("Submit",
          textAlign: TextAlign.center,
          style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
      );
    }
  }


  String _validateEmail(String value) {
    if (value.trim().length < 1) return 'Email can not be empty';

    return null;
  }

  void _validateInputsAndSubmit() async{
    //login user
    final authState = Provider.of<AuthState>(context);

    if(!authState.isLoading) {

      if (_formKey.currentState.validate()) {
        //If all data are correct then save data to out variables
        _formKey.currentState.save();
        setState(() {_isLoading = true;});

        try{
         
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


      } else {
        //If all data are not valid then start auto validation.
        setState(() {
          _autoValidate = true;
        });
      }
    }

  }

}