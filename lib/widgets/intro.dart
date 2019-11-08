import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:laundry/database/AppDb.dart';
import 'package:laundry/widgets/login.dart';

class Intro extends StatefulWidget {
  Intro({Key key}) : super(key: key);

  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "FAST PICKUP",
        description: "Our pickup and delivery service is the most convenient way to go about your life.",
        pathImage: "assets/images/pickup.png",
        backgroundColor: Color(0xffFED9BC),
      ),
    );
    slides.add(
      new Slide(
        title: "EFFICIENT LAUNDRY",
        description: "We give an elegant laundry service",
        pathImage: "assets/images/laundry2.jpg",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "PERFECT DELIVERY",
        description:
        "We delivered your well packages clothes to your door step",
        pathImage: "assets/images/delivery.jpg",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() async {
    AppDb appDb = new AppDb();
    await appDb.fetch("showInitialPage");
    
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
