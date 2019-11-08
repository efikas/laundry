import 'package:flutter/material.dart';
import 'package:laundry/models/UserModel.dart';
import 'package:provider/provider.dart';
import 'package:laundry/store/authState.dart';
import 'package:laundry/store/userState.dart';
import 'package:laundry/widgets/partials/Loading.dart';
import 'package:laundry/widgets/partials/NetworkError.dart';
import 'package:laundry/widgets/partials/ProfileFront.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.addStatusListener((AnimationStatus status) {
      if (!_focusNode.hasFocus && _animationController.isCompleted) {
        setState(() {
          FocusScope.of(context).requestFocus(_focusNode);
          print('complete  ${_focusNode.hasFocus}');
        });
      }else if(_focusNode.hasFocus && !_animationController.isCompleted){
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  Widget getProfile(User userInfo, BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: (MediaQuery.of(context).size.height / 6) - 75),
        Container(
          width: 150.0,
          height: 150.0,
          child: Stack(
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
                                image: NetworkImage(userInfo.image),
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
            ],
          ),
        ),
        SizedBox(height: 50.0),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: ProfileFront(),
        ),
      ],
    );
  }

/**
 * Compose the widget for the the profile page
 */
  Widget normalizeProfile(dynamic userState) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            width: MediaQuery.of(context).size.width,
            child: getProfile(userState.getUserInfoModel, context),
          ),
        )
    );
  }

  //handle each network state
  dynamic loadProfile() {
    final userState = Provider.of<UserState>(context);
    final authState = Provider.of<AuthState>(context);

    if(userState.isLoading) {
      return Loading();
    }
    else if(!userState.getProfileInfo.containsKey("uid")) {
      return NetworkError(
        reload: userState.getUserData(authState.getAuthInfo["token"], authState.getAuthInfo["uid"]),
      );
    }
    else if(userState.getProfileInfo.containsKey("uid")) {
      
      return normalizeProfile(userState);
    }
    else {
      return Center(
        child: Text("No user information available"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return loadProfile();
  }
}