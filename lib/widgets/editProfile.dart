import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:laundry/models/UserModel.dart';
import 'package:laundry/store/userState.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:image_picker/image_picker.dart';



// Create a Form widget.
class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  TextStyle myStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  dynamic userState;
  bool _isLoading = false;
  bool _autoValidate = false;
  String _email;
  String _fullname;
  String _address;
  String _phone;
  User _user;
  File _image;


  dynamic imageNormalizer(){
    if(_image == null) 
      return NetworkImage(_user.image);

    return FileImage(_image );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });

    //upload image
    _upload();
  }

  @override
  Widget build(BuildContext context) {
    userState = Provider.of<UserState>(context);
    _user = userState.getUserInfoModel;

    final headerImage = Stack(
            children: <Widget>[
              Container(
                width: 160.0,
                height: 160.0,
                decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    boxShadow: [
                      BoxShadow(blurRadius: 10.0, color: Colors.blue.shade100, spreadRadius: 5.0)
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade500,
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.blue.shade300,spreadRadius: 2.0)
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            image: DecorationImage(
                                image: imageNormalizer(),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.blue.shade700, spreadRadius: 2.0)
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 105.0,
                left: 105.0,
                child:  FloatingActionButton(
                  mini: true,
                  child: Icon(Icons.camera_alt, color: Colors.white,),
                  onPressed: (){
                      getImage();
                  },
                ),
              ),
            ],
          );
                
    final emailField = TextFormField(
        style: myStyle,
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        initialValue: _user.email,
        enabled: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
        initialValue: _user.fullname,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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

    final addressField = TextFormField(
        style: myStyle,
        minLines: 3,
        maxLength: null,
        maxLines: null, 
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        initialValue: _user.address,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: 'Home Address',
            alignLabelWithHint: true,
            hasFloatingPlaceholder: true,
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

    final phoneField = TextFormField(
        style: myStyle,
        cursorColor: Colors.white,
        keyboardType: TextInputType.phone,
        initialValue: _user.phone,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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

    final animateRegisterButton = Animator(
        duration: Duration(milliseconds: 300),
        cycles: 1,
        builder: (anim) => Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
          ),
          width: _buttonAnimate(anim.value),
          child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
          ),
          child: MaterialButton(
            onPressed: () {
              _validateInputsAndSubmit();
            },
            padding: EdgeInsets.fromLTRB(1.0, 15.0, 10.0, 15.0),
            child: _buttonLabel(anim.value ),
          ),
        ),
      ),
    );



    return new Scaffold(
      appBar: new AppBar(
        // custom drawer toggler to close the bottom sheet
        leading: new IconButton(icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),

        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text("Profile"),
        iconTheme: new IconThemeData(color: Colors.white),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      
      body: Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(scrollDirection: Axis.vertical,
                child: Padding(
                    padding: EdgeInsets.only(top: 20),
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
                              SizedBox(height: 35.0,),
                              Column(
                                children: <Widget>[
                                    Container(
                                      child: Card(
                                        elevation: 10,
                                        margin: EdgeInsets.all(0.0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                                        child:Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: new BorderRadius.only(
                                                topLeft: const Radius.circular(40.0),
                                                topRight: const Radius.circular(40.0)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(height: 20.0),
                                                emailField,
                                                SizedBox(height: 25.0,),
                                                fullnameField,
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
                                        ),
                                      ),
                                    )
                                  ],
                              ),
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
      ),
    );
    }

  double _buttonAnimate(double tween) {
    final authState = Provider.of<UserState>(context);

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
    final authState = Provider.of<UserState>(context);

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
    else if (RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value) == false) return 'Email not valid';

    return null;
  }

  String _validateFullname(String value) {
    if (value.trim().length < 1) return 'Fullname can not be empty';

    return null;
  }


  String _validatePhone(String value) {
    if (value.trim().length < 1) return 'Phone can not be empty';

    return null;
  }

  String _validateAddress(String value) {
    if (value.trim().length < 1) return 'Home Address can not be empty';

    return null;
  }

  void _upload() async{
   if (_image == null) return;
   final userState = Provider.of<UserState>(context);

   String fileName = _image.path.split("/").last;

    try{
      Map<String, dynamic> response = null;
      response = await userState.uploadImage(userState.getUserInfoModel.uid, _image, fileName);
      _resp(response, "Image Updated Successfully!");
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
    }

 }


  void _validateInputsAndSubmit() async{
    if(!userState.isLoading) {

      if (_formKey.currentState.validate()) {
        //If all data are correct then save data to out variables
        _formKey.currentState.save();
        setState(() {_isLoading = true;});

        Map<String, String> _credentials = {};
        _credentials["uid"] = userState.getUserInfoModel.uid;
        _credentials["name"] = _fullname;
        _credentials["phone"] = _phone;
        _credentials["address"] = _address;
        print(_fullname);

        // try{
        //   Map<String, dynamic> response = null;
        //   response = userState.updateProfile(_credentials);
        //   _resp(response, "Profile Updated Successfully!");
            
        //     setState(() {_isLoading = false;});
        // }
        // catch (error) {
        //   print(error);
        //   Flushbar(
        //     message: "Network Error, Check your internet connection.!",
        //     icon: Icon(
        //       Icons.info_outline,
        //       size: 28.0,
        //       color: Colors.red[300],
        //     ),
        //     duration: Duration(seconds: 3),
        //     leftBarIndicatorColor: Colors.red[300],
        //     flushbarPosition: FlushbarPosition.TOP,
        //   )..show(context);
        //   setState(() {_isLoading = false;});
        // }


      } else {
        //If all data are not valid then start auto validation.
        setState(() {
          _autoValidate = true;
        });
      }
    }

  }

  _resp(dynamic response, String success) async {
    //update user state with user informations
      if(response != null && response.containsKey("uid")) {
        Flushbar(
          message: success,
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.green[300],
          ),
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.green[300],
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context);
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
  }
}