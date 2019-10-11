import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laundry/store/userState.dart';


class ProfileFront extends StatelessWidget {
  List<Widget> _profileOutline = [];
  Map userInfo = {
    'email': Icons.mail,
    'fullname': Icons.person,
    'phone': Icons.phone,
    'address': Icons.home,
  };

  String normalizeInfo (dynamic state, String key) => state[key];

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);


    userInfo.forEach((dynamic key, dynamic value) {
      _profileOutline.add(
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            leading: Icon(value, color: Colors.white70,),
            title: Text( capitalize(key),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54
              ),
            ),
            subtitle: Text(normalizeInfo(userState.getProfileInfo, key), style: TextStyle(color: Colors.white),),
          )
      );

      _profileOutline.add(Divider(color: Colors.white30,));
    });

    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height - 450,
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
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    ..._profileOutline,
                  ],
                ),
              )
          ),
        )
      ],
    );
  }
}