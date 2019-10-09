import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  final dynamic reload;
  NetworkError({Key key, @required this.reload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              height: 80.0,
              child: new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/no-wifi.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          new Text("No Internet Connection"),
          SizedBox(height: 15.0),
          new FlatButton(
              color: Colors.red,
              child: new Text("Retry", style: TextStyle(color: Colors.white),),
              onPressed: () => reload,
          ),
        ],
      ),
    );
  }
}