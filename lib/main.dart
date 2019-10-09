import 'package:flutter/material.dart';
import 'package:laundry/store/centralStore.dart';
import 'package:laundry/widgets/addressPage.dart';
import 'package:laundry/widgets/makePaymentPage.dart';
import 'package:laundry/widgets/paymentPage.dart';
import 'package:laundry/widgets/pickupRequestSuccess.dart';
import 'package:laundry/widgets/pickup_request.dart';
import 'package:laundry/widgets/register.dart';
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
        // home: Intro(),
        home: Register(),
      ),
    );
  }
}
