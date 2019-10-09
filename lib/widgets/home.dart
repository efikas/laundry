import 'package:flutter/material.dart';
import 'package:laundry/widgets/profile.dart';
import 'package:laundry/widgets/services.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Services(switchPage: (){},),
    Profile(),
  ];

  final List<String> _title = ["Services","Profile"];

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text(_title[_currentIndex]),
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
}