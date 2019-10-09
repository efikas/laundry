import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:laundry/models/Service.dart';
import 'package:laundry/services/services.dart';

class ServiceState extends ChangeNotifier  {

  Services service = new Services();

  Map<String, Service> _ourServices = {
    "tshirt": Service.fromMap(
      {
        "key": "tshirt",
        "quantity": 0,
        "price": "500",
        "slug": "T-SHIRT",
        "image": "assets/images/shirt.jpeg"
      }
    ),
      "trouser": Service.fromMap(
        {
          "key": "trouser",
          "quantity": 0,
          "price": "500",
          "slug": "TROUSER",
          "image": "assets/images/trouser.jpeg"
        }
      ),
      "towel": Service.fromMap(
        {
          "key": "towel",
          "quantity": 0,
          "price": "600",
          "slug": "TOWEL",
          "image": "assets/images/towel.jpeg"
        }
      ),
      "skirt": Service.fromMap(
        {
          "key": "skirt",
          "quantity": 0,
          "price": "500",
          "slug": "SKIRT",
          "image": "assets/images/skirt.jpeg"
        }
      ),
      "jacket": Service.fromMap(
        {
          "key": "jacket",
          "quantity": 0,
          "price": "300",
          "slug": "JACKET",
          "image": "assets/images/jacket.jpeg"
        }
      ),
      "pant": Service.fromMap(
        {
          "key": "pant",
          "quantity": 0,
          "price": "200",
          "slug": "PANT",
          "image": "assets/images/pant.jpeg"
        }
      ),
      "jeans": Service.fromMap(
        {
          "key": "jeans",
          "quantity": 0,
          "price": "400",
          "slug": "JEANS",
          "image": "assets/images/jeans.jpeg"
        }
      ),
  };

  //information of the scheduled laundry pickup
  Map<String, String> _pickUpInfo = {
    "fullname": "",
    "address": "",
    "phone": "",
  };

  bool _isLoading = false;

  Map<String, Service> get getServices => _ourServices;
  Map<String, String> get pickUpInfo => _pickUpInfo;
  bool get isLoading => _isLoading;

  void set getServices(Map<String, Service> result) {
    _ourServices = result;
    notifyListeners();
  }

  void set pickUpInfo(Map<String, String> info) {
    _pickUpInfo = info;
    notifyListeners();
  }

  increment(String key){
    _ourServices = {
        ..._ourServices,
        key: Service.fromMap(
        {
          ..._ourServices[key].toMap(),
          "quantity": _ourServices[key].quantity + 1,
        }
      )
    };
    notifyListeners();
  }

  decrement(String key){
    _ourServices = {
      ..._ourServices,
      key: Service.fromMap(
        {
          ..._ourServices[key].toMap(),
          "quantity": (_ourServices[key].quantity < 1) ? 0 : _ourServices[key].quantity - 1,
        }
      )
    };
    notifyListeners();
  }

  resetServices(){
     _ourServices.keys.forEach((String key){
        _ourServices = {
          ..._ourServices,
          key: Service.fromMap({
            ..._ourServices[key].toMap(),
            "quantity": 0,
          })
        };
     });
    notifyListeners();
  }
}