import 'dart:async';
import 'package:laundry/database/AppDb.dart';
import 'package:laundry/database/UserDb.dart';
import 'package:laundry/store/authState.dart';
import 'package:laundry/store/serviceState.dart';
import 'package:laundry/store/userState.dart';
import 'package:laundry/widgets/intro.dart';
import 'package:laundry/widgets/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:laundry/widgets/home.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  AnimationController _iconAnimationController;
  CurvedAnimation _iconAnimation;

  void handleTimeout() {
      //load datas from local storage
      loadDatas();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 5);
    return new Timer(duration, handleTimeout);
  }


  @override
  void initState() {
    super.initState();

    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2000));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));

    _iconAnimationController.forward();

    startTimeout();
  }

  void loadDatas () async {
    final userState = Provider.of<UserState>(context);
    final authState = Provider.of<AuthState>(context);
    final serviceState = Provider.of<ServiceState>(context);

    AppDb appDb = new AppDb();

    // load all initial state data
    dynamic user = await appDb.fetch("user");
    dynamic auth = await appDb.fetch("auth");
    dynamic services = await appDb.fetch("services");

    await appDb.store("way", "hello");

    print(await appDb.fetch("way") as String);

    if (user != null) userState.getProfileInfo = await appDb.fetch("user");
    if (auth != null) authState.getAuthInfo = await appDb.fetch("auth");
    if (services != null) serviceState.getServices = await appDb.fetch("services");

    bool showInitialPage = await appDb.fetch("showInitialPage");

    //check if it is user first time
    if(showInitialPage != null && showInitialPage == false) {

      ///check if user is authenticated
      if(authState.getAuthInfo["isAuthenticated"] != null && authState.getAuthInfo["isAuthenticated"] == true) {
        Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Home()), (Route<dynamic> route) => false);
      }
      else {
        Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
      }
    }
    else {
      Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Intro()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.blueAccent,
        child: new Center(
            child: new Image(
              image: new AssetImage("assets/images/logo.jpg"),
              width: _iconAnimation.value * 100,
              height: _iconAnimation.value * 100,
            ),
            ),
      ),
    );
  }
}