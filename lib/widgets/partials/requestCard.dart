import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  String imageUrl, price, slug, quantity;
  Function increment, decrement;
  RequestCard({
      Key key,
      @required this.imageUrl,
      @required this.quantity,
      @required this.price,
      @required this.slug,
      @required this.increment,
      @required this.decrement,
    }) : assert(imageUrl != null),
        assert(quantity != null),
        assert(slug != null),
        assert(price != null),
        assert(increment != null),
        assert(decrement != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(imageUrl, width: 100.0, height: 100.0,),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(slug, style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 20),
                  Text("#$price/piece", style: TextStyle(
                    color: Colors.black38
                  ),),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ClipRect(
                child: Material(
                  color: Colors.blueAccent, // button color
                  child: InkWell(
                    splashColor: Colors.white38, // inkwell color
                    child: SizedBox(width: 30, height: 30, child: Icon(Icons.remove, color: Colors.white,)),
                    onTap: (){ decrement(); },
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)
                ),
                child: Center(child: Text(quantity),),
              ),
              SizedBox(width: 10,),
              ClipRect(
                child: Material(
                  color: Colors.blueAccent, // button color
                  child: InkWell(
                    splashColor: Colors.white38, // inkwell color
                    child: SizedBox(width: 30, height: 30, child: Icon(Icons.add, color: Colors.white,)),
                    onTap: (){
                      increment();
                    },
                  ),
                ),
              ),
              SizedBox(width: 20,),
            ],
          )
        ],
      ),
    );
  }
}