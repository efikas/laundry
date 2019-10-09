import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:laundry/store/authState.dart';
import 'package:laundry/store/userState.dart';
import 'package:laundry/widgets/forgot_password.dart';
import 'package:laundry/widgets/login.dart';
import 'package:laundry/widgets/registrationSuccess.dart';



// Create a Form widget.
class Register extends StatefulWidget {
  @override
  MyRegister createState() {
    return MyRegister();
  }
}



class MyRegister extends State<Register> {
  TextStyle myStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _autoValidate = false;
  String _email;
  String _fullname;
  String _password;
  String _c_password;
  String _phone;
  String _address;


  @override
  Widget build(BuildContext context) {

    final headerImage = Container(
                  width: 60.0,
                  height: 60.0,
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

    final registerText = Text("Create your account",
          style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          );

    final emailField = TextFormField(
        style: myStyle,
        cursorColor: Colors.white,
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
        onChanged: (String val) => _email = val,
    );
                

    final fullnameField = TextFormField(
        style: myStyle,
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Username",
            labelText: 'Fullname',
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
        validator: _validateFullname,
        onChanged: (String val) => _fullname = val,
    );


    final passwordField = TextFormField(
        style: myStyle,
        obscureText: true,
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Password",
            labelText: 'Password',
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
        validator: _validatePassword,
        onChanged: (String val) => _password = val,
    );

    final c_passwordField = TextFormField(
        style: myStyle,
        obscureText: true,
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Password",
            labelText: 'Re-enter Password',
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
        validator: _validateCPassword,
        onChanged: (String val) => _c_password = val,
    );

    final phoneField = TextFormField(
        style: myStyle,
        cursorColor: Colors.white,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // hintText: "Username",
            labelText: 'Mobile Number',
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
        validator: _validatePhone,
        onChanged: (String val) => _phone = val,
    );

    final addressField = TextFormField(
        style: myStyle,
        minLines: 3,
        maxLength: null,
        maxLines: null, 
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: 'Home Address',
            hasFloatingPlaceholder: true,
            alignLabelWithHint: true,
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
        validator: _validateAddress,
        onChanged: (String val) => _address = val,
    );

    final animateRegisterButton = Animator(
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
        MaterialPageRoute(builder: (context) => Login()));
      },
      child: Text("Sign In",
        textAlign: TextAlign.center,
        style: myStyle.copyWith(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
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
            child: SingleChildScrollView(scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0,),
                            headerImage,
                            SizedBox(height: 15.0,),
                            registerText,
                            SizedBox(height: 25.0,),
                            emailField,
                            SizedBox(height: 25.0,),
                            fullnameField,
                            SizedBox(height: 25.0,),
                            passwordField,
                            SizedBox(height: 25.0,),
                            c_passwordField,
                            SizedBox(height: 25.0,),
                            phoneField,
                            SizedBox(height: 25.0,),
                            addressField,
                            SizedBox(height: 30.0,),
                            animateRegisterButton,
                            SizedBox(height: 55.0,),
                          ],
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already have an account?  ",
                              textAlign: TextAlign.center,
                              style: myStyle.copyWith(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                            signIn
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
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
      return Text("Register",
          textAlign: TextAlign.center,
          style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
      );
    }
    else {
      return Text("Register",
          textAlign: TextAlign.center,
          style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
      );
    }
  }
  
  String _validateEmail(String value) {
    if (value.trim().length < 1) return 'Email can not be empty';
    else if (RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value) == false) return 'Email not valid';

    return null;
  }

  String _validateAddress(String value) {
    if (value.trim().length < 1) return 'Address can not be empty';

    return null;
  }

  String _validateFullname(String value) {
    if (value.trim().length < 1) return 'Fullname can not be empty';

    return null;
  }

  String _validatePassword(String value) {
    if (value.trim().length < 1) return 'Password can not be empty';

    return null;
  }

  String _validateCPassword(String value) {
    if (value.trim().length < 1) return 'Password can not be empty';
    else if (value != _password) return 'Password does not match';
    else return null;
  }


  String _validatePhone(String value) {
    if (value.trim().length < 1) return 'Phone can not be empty';

    return null;
  }

  void _validateInputsAndSubmit() async{
    final authState = Provider.of<AuthState>(context);

    if(!authState.isLoading) {

      if (_formKey.currentState.validate()) {
        //If all data are correct then save data to out variables
        _formKey.currentState.save();
        setState(() {_isLoading = true;});

        Map<String, String> _credentials = {};
        _credentials["email"] = _email;
        _credentials["fullname"] = _fullname;
        _credentials["password"] = _password;
        _credentials["phone"] = _phone;
        _credentials["address"] = _address;


        try{
          Map<dynamic, dynamic> response = await authState.register(_credentials);

          print(response);
          //update user state with user informations
            if(response != null && response.containsKey("uid")) {
               Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (BuildContext context) => RegistrationSuccess()), (Route<dynamic> route) => false);
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


      } else {
        //If all data are not valid then start auto validation.
        setState(() {
          _autoValidate = true;
        });
      }
    }

  }
}