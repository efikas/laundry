import 'package:flutter/material.dart';
import 'package:laundry/widgets/editProfile.dart';
import 'package:laundry/widgets/pickups.dart';
import 'package:laundry/widgets/profile.dart';
import 'package:laundry/widgets/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Services(),
    Profile(),
    Pickups(),
  ];

  final List<String> _title = ["Services", "Profile", "Pickup History"];

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Center(
         child: Text(_title[_currentIndex]),
       ),
       actions: <Widget>[
         (_currentIndex == 1) 
            ? IconButton(
                icon: Icon(Icons.edit, color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => EditProfile())
                  );
                },
              ) 
            : SizedBox(width: 0,),
         SizedBox(width: 5,),
       ],
     ),
     body: _children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped, // new
       currentIndex: _currentIndex,
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.group_work),
           title: new Text('Services'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('Profile')
         ),
         BottomNavigationBarItem(
           icon: Icon(FontAwesomeIcons.truckPickup),
           title: Text('Requests')
         )
       ],
     ),
   );
 }

 void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

//  Future<Map<String, dynamic>>fetchConfirmationDatas() async{
//     final userState = Provider.of<UserState>(context);
//     final authState = Provider.of<AuthState>(context);
//     final serviceState = Provider.of<ServiceState>(context);

//     AppDb appDb = new AppDb();

//     // load all initial state data
//     dynamic user = await appDb.fetch("user");
//     dynamic authentication = await appDb.fetch("auth");
//     dynamic services = await appDb.fetch("services");

//     if (user != null) userState.getProfileInfo = user;
//     if (authentication != null) authState.getAuthInfo = authentication;
//     if (services != null) serviceState.getServices = services;

//     bool isOnboarded = await appDb.fetch("showInitialPage");

//     return {
//       "isOnboarded" : isOnboarded,
//       "authentication" : authentication,
//       "services" : services,
//       "user" : user,
//     };
//   }
}