import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laundry/store/centralStore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchCard extends StatefulWidget {
  Function searchAndNavigate;
  SearchCard({Key key, @required this.searchAndNavigate}) : super(key: key);
  @override
  _SearchCard createState() => new _SearchCard();
}

class _SearchCard extends State<SearchCard>{

  double _searchWidth = 0;
  bool _searchToggle = false;
  var _hour = new DateTime.now().hour;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return AnimatedContainer(
      height: 60,
      width: 60 + _searchWidth,
      duration: Duration(milliseconds: 500),
      child: Card(
        color: Colors.white,
        child: Row(children: <Widget>[
          IconButton(
            icon: (_searchWidth == 0) ? Icon(Icons.location_on) : Icon(Icons.arrow_back),
            onPressed: (){
              setState(() {_searchToggle = !_searchToggle;});

              if(_searchToggle == true){
                setState(() {
                  _searchWidth = MediaQuery.of(context).size.width - 60;
                });
              }
              else {
                setState(() { _searchWidth = 0; });
              }
            },
          ),
          AnimatedContainer(
            duration: Duration(microseconds: 800),
            height: 60,
            width: _searchWidth,
            child: SearchBox(hour: _hour, searchAndNavigate: widget.searchAndNavigate)
          )
        ],
        ),
      )
    );
  }
}

class SearchBox extends StatelessWidget {
  var hour;
  Function searchAndNavigate;
  SearchBox({Key key, @required this.hour, @required this.searchAndNavigate}):super(key:key);

  TextStyle myStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color _fieldColor = (hour < 20) ? Color.fromRGBO(34, 35, 79, 1) : Color.fromRGBO(133, 140, 253, 1);
    final centralState = Provider.of<CentralState>(context);

    final searchTextField = AutoCompleteTextField<String>(
        controller: searchController,
        style: myStyle.copyWith(
          color: _fieldColor
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'City',
          labelStyle: TextStyle(color: _fieldColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: new BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.red)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.redAccent)
          ),
      ),
      suggestions: centralState.locationList,
      itemSubmitted: (item) {
        searchController.text = item;
        centralState.location = item;
        searchAndNavigate(item);
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemFilter: (item, query) {
        return item.toLowerCase()
            .startsWith(query.toLowerCase());
      },

      itemBuilder: (context, item) {
        return ListTile(
            title: Text(item,
            style: TextStyle(
              fontSize: 16.0
            ),
          ),
        );
      },
      submitOnSuggestionTap: true,
      clearOnSubmit: false,
      textChanged: (item) {},
    );

    return Form(
      key: _formKey,
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        child: searchTextField,
      ),
    );
  }
}