import 'package:flutter/material.dart';
import 'package:laundry/database/AppDb.dart';
import 'package:laundry/store/centralStore.dart';
import 'package:laundry/widgets/addressPage.dart';
import 'package:laundry/widgets/login.dart';
import 'package:laundry/widgets/makePaymentPage.dart';
import 'package:laundry/widgets/paymentPage.dart';
import 'package:laundry/widgets/pickupRequestSuccess.dart';
import 'package:laundry/widgets/pickup_request.dart';
import 'package:laundry/widgets/register.dart';
import 'package:laundry/widgets/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:laundry/store/authState.dart';
import 'package:laundry/store/userState.dart';
import 'package:laundry/store/serviceState.dart';
import 'package:laundry/widgets/intro.dart';
import 'package:laundry/widgets/pickupLocation.dart';
import 'package:laundry/widgets/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(builder: (_) => AuthState()),
        ChangeNotifierProvider(builder: (_) => UserState()),
        ChangeNotifierProvider(builder: (_) => ServiceState()),
        ChangeNotifierProvider(builder: (_) => CentralState()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => Home(),
          '/pickupRequest': (BuildContext context) => PickupRequest(),
          '/pickUpRequestSuccess': (BuildContext context) => PickUpRequestSuccess(),
          '/addressPage': (BuildContext context) => AddressPage(),
          '/makePaymentPage': (BuildContext context) => MakePaymentCard(),
        },
        // home: PaymentPage(),
        // home: MakePaymentCard(),
        home: FutureBuilder<dynamic>(
            future: fetchConfirmationDatas(),
            builder: (buildContext, snapshot) {
              if (snapshot.hasData) {
                /// Check if the user has a persisted authentication data
                if (snapshot.data["authentication"] != null) {
                  if(checkAuthenticated(snapshot.data["authentication"])){
                    return Home();
                  }
                  
                  return Login();
                }
                else if(snapshot.data["isOnboarded"] == true){
                  return Login();
                }
                return Intro();
              } else {
                return Stack(
                  children: <Widget>[
                    Container(color: Colors.blueAccent),
                    Center(
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }


  bool checkAuthenticated(data){
    if(data["isAuthenticated"] == true ) {
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>>fetchConfirmationDatas() async{
    AppDb appDb = new AppDb();

    // load all initial state data
    dynamic user = await appDb.fetch("user");
    dynamic authentication = await appDb.fetch("auth");
    dynamic services = await appDb.fetch("services");
    bool isOnboarded = await appDb.fetch("showInitialPage");

    return {
      "isOnboarded" : isOnboarded,
      "authentication" : authentication,
      "services" : services,
      "user" : user,
    };
  }

}
