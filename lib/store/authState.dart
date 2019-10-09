import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:laundry/services/services.dart';

class AuthState extends ChangeNotifier  {

  bool _isLoading = false;
  Map<String, dynamic> _authInfo = {
    "isAuthenticated": false,
    "token": "",
    "uid": ""
  };
  Services service = new Services();

  bool get isLoading => _isLoading;

  Map<String, dynamic> get getAuthInfo =>  _authInfo;

  void set getAuthInfo (Map<String, dynamic> info) {
    _authInfo = info;
    notifyListeners();
  }


  Future<dynamic> authenticate(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, String> _userCredentials = {};
    Map<String, dynamic> response;
    _userCredentials["email"] = email;
    _userCredentials["password"] = password;

    try {
      response = await service.authenticate(_userCredentials);

      if(response != null && response.containsKey("uid")) {
        Map<String, dynamic> _info = {};
        _info["isAuthenticated"] = true;
        _info["token"] = response["remember_token"];
        _info["uid"] = response["uid"];
        this.getAuthInfo = _info;

        _isLoading = false;
        notifyListeners();
        return response;
      }
    }
    catch(error){
      print("error");
      print(error);
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }

  Future<dynamic> register(Map<String,String> _userCredentials) async {
    _isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic> response = await service.register(_userCredentials);

      if(response != null && response.containsKey("uid")) {
        _isLoading = false;
        notifyListeners();
        return response;
      }
    }
    catch(error){
      print("error");
      print(error);
    }

    _isLoading = false;
    notifyListeners();
    return {};
  }

}