import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class CentralState extends ChangeNotifier  {
  List<String> _locations = [];
  String _location = "";

  List<String> get locationList => _locations;
  String get location => _location;

  void set locationList(List<String> locations){
    _locations = locations;
    notifyListeners();
  }

  void set location(String location){
    _location = location;
    notifyListeners();
  }

  // Future<void> loadCities() async {
  //   dynamic res = await loadAsset();
  //   Map<String, dynamic> jsonCities = json.decode(res.toString());
  //   jsonCities.forEach((String key, dynamic value){
  //       _cities = Set.of([..._cities, ...value]).cast<String>().toList(); //remove duplicate from list
  //   });
  //   notifyListeners();
  // }

  // Future<String> loadAsset() async {
  //   return await rootBundle.loadString('assets/data/countries.json');
  // }

}