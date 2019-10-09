import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:laundry/widgets/partials/searchCard.dart';
import 'package:location/location.dart';


GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class PickupLocation extends StatefulWidget {
  PickupLocation({Key key}) : super(key: key);

  _PickupLocationState createState() => _PickupLocationState();
}

class _PickupLocationState extends State<PickupLocation> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;

  static const LatLng _center = const LatLng(37.42796133580664, -122.085749655962);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final Set<Marker> _markers = {};
  
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: homeScaffoldKey,
        appBar: AppBar(
          title: const Text("PlaceZ"),
          actions: <Widget>[
            isLoading
                ? IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                    },
                  ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(target: _center,
                      zoom: 11.0),
                      mapType: _currentMapType,
                      markers: _markers,
                      onCameraMove: _onCameraMove,
                      
              ),
            ),
            Positioned(
            top: 10,
            child: SearchCard(searchAndNavigate: searchAndNavigate),
          ),
            // Expanded(child: expandedChild)
          ],
        ));
  }

  navigateCamera(Placemark location){
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(location.position.latitude, location.position.longitude), 
        zoom: 15.0
      ),));
  }

searchAndNavigate(address) {
  Geolocator().placemarkFromAddress(address).then((List<Placemark> result){
    if(result.length > 0){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(result[0].position.latitude, result[0].position.longitude), 
        zoom: 15.0
      ),));
    }
    
  }
  );
}



  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blueAccent,
      child: Icon(icon, size: 36.0,),
    );
  }
}