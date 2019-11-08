import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:laundry/database/AppDb.dart';
import 'package:laundry/models/ServiceModel.dart';
import 'package:laundry/services/services.dart';
import 'package:laundry/store/servicesData.dart';

class ServiceState extends ChangeNotifier  {

  Services service = new Services();

  bool _isLoading = false;
  Map<String, Map<String, Service>> _ourServices =  laundryServices;
 
  ///information of the scheduled laundry pickup
  Map<String, String> _pickUpInfo = {
    "fullname": "",
    "address": "",
    "phone": "",
  };

  Map<String, dynamic> _payment = {
    "totalPrice": 0,
    "paymentStatus": "not paid",
  };


  ///GETTERS
  Map<String, Map<String, Service>> get getServices => _ourServices;
  Map<String, String> get pickUpInfo => _pickUpInfo;
  bool get isLoading => _isLoading;

  String get itemInCart => (){
    ///get the total number of clothes added 
    ///to the laundry basket
    int _total = 0;
    _ourServices.values.toList().forEach((Map<String, Service> category){
      category.values.toList().forEach((Service service){
        _total += service.quantity;
      });
    });
    
    return _total.toString();
  }();

  String get priceOfItemsInCart => (){
    ///get the price for the laundry in the laundry basket
    int _totalPrice = 0;
    _ourServices.values.toList().forEach((Map<String, Service> category){
      category.values.toList().forEach((Service service){
        _totalPrice += service.quantity * service.price;
      });
    });

    ///update the price on the _payment stet item
    payment = {
      ...payment,
      "totalPrice": _totalPrice,
    };

    return _totalPrice.toString();
  }();

  Map<String, dynamic> get payment => _payment;


  ///SETTERS
  void set getServices(Map<String, Map<String, Service>> result) {
    _ourServices = result;
    notifyListeners();
  }

  void set pickUpInfo(Map<String, String> info) {
    _pickUpInfo = info;
    notifyListeners();
  }

  void set payment(Map<String, dynamic> value) {
    _payment = value;
    notifyListeners();
  }



  ///MIDDLEWARE METHODS
  increment(String category, String key){
    _ourServices = {
      ..._ourServices,

      category: {
        ... _ourServices[category],
        key: Service.fromMap(
          {
            ..._ourServices[category][key].toMap(),
            "quantity": _ourServices[category][key].quantity + 1,
          }
        )
      }
    };
    notifyListeners();
  }

  decrement(String category, String key){
    _ourServices = {
      ..._ourServices,

      category: {
        ... _ourServices[category],
        key: Service.fromMap(
          {
            ..._ourServices[category][key].toMap(),
            "quantity": _ourServices[category][key].quantity - 1,
          }
        )
      }
    };
    notifyListeners();
  }

  resetServices(){
    ///loop through the services category
     _ourServices.keys.forEach((String categoryKey){
       ///loop through the category items
      _ourServices[categoryKey].keys.forEach((String key){
        _ourServices = {
          ..._ourServices,
          categoryKey: {
            ..._ourServices[categoryKey],
            key: Service.fromMap({
              ..._ourServices[categoryKey][key].toMap(),
              "quantity": 0,
            })
          }
        };
      });
    });
    notifyListeners();
  }

  checkforServicesPriceChange() async {
    /// check if there is any price changes between prices coming
    /// from the server and the one one stored in the phone storage
    /// then update the state and the phone store if there is changes
    
    bool shouldUpdate = false;
    
    dynamic serverServices = await service.getServices();

    ///convert the list to object of Service
    Map<String, Service> serverServicesObject = {};

    serverServices.forEach((dynamic item){
      ///cast item to map
      Map<String, dynamic> newItem = Map<String, dynamic>.from(item);
      serverServicesObject = {
        ...serverServicesObject,
        newItem["slug"]: Service.fromMap(newItem)
      };
    });
    
    ///check for price difference
    _ourServices.keys.toList().forEach((String categoryKey){
      _ourServices[categoryKey].keys.toList().forEach((String itemKey){

        /// compare prices
        if(_ourServices[categoryKey][itemKey].price != serverServicesObject[itemKey].price){
          
          ///update the state
          _ourServices = {
            ..._ourServices,
            categoryKey: {
              ..._ourServices[categoryKey],
              itemKey: Service.fromMap({
                ..._ourServices[categoryKey][itemKey].toMap(),
                "price": serverServicesObject[itemKey].price,
              })
            }
          };
          shouldUpdate = true;
        }
      });

    });

    if(shouldUpdate == true){
      ///update data storage
      AppDb appDb = new AppDb();
      appDb.store("services", _ourServices);
      
      notifyListeners();
    }
  }

  sendPickupRequest() async {
    _isLoading = true;
    notifyListeners();

    ///pickup request Map format
    ///
    /// {
    ///   laundry:[
    ///       {...}
    ///       {...}
    ///       {...}
    ///   ],
    ///   contactInfo: {
    ///       name: "",
    ///       phone: "",
    ///       address: "",
    ///     },
    ///   payment: {
    ///       totalPrice: 4500,
    ///       paymentStatus: "not paid",
    ///   }
    /// }
    

    dynamic submissionResponse = await service.sendPickupRequest({
      "laundry": getPickupLaundrys(),
      "contactInfo": _pickUpInfo,
      "payment": _payment,
    });

    _isLoading = false;
    notifyListeners();

    if(submissionResponse != null ){
      return submissionResponse;
    }

    return null;
  }


  List<Map<String, dynamic>> getPickupLaundrys(){
    List<Map<String, dynamic>> laundry = [];

    ///check select laundry services
    _ourServices.keys.toList().forEach((String categoryKey){
      _ourServices[categoryKey].keys.toList().forEach((String itemKey){

        if(_ourServices[categoryKey][itemKey].quantity > 0){
          laundry.add(_ourServices[categoryKey][itemKey].toMap());
        }
      });

    });

    return laundry;
  }
}