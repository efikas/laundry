import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:laundry/models/User.dart';
import 'package:laundry/services/services.dart';

class UserState extends ChangeNotifier  {

  Services service = new Services();
  Map<String, dynamic> _userInfo = {
    "uid": "e455rttyye45wd246",
    "fullname": "Emmanuel Samson",
    "username": "emma",
    "phone": "080863820",
    "address": "D23, Ajao Avenue, Gwarimpa Estate Abuja",
    "image": ""
  };
  bool _isLoading = false;

  Map<String, dynamic> get getProfileInfo => _userInfo;
  bool get isLoading => _isLoading;


  void set getProfileInfo(Map<String, dynamic> result) {
    _userInfo = result;
    notifyListeners();
  }

  User get getUserInfoModel =>  User.fromMap(_userInfo);

  Future<dynamic> getUserData(String token, String uid) async {
    //check if value is in state
    // if (_userInfo == null) {
    //   _isLoading = true;
    //   notifyListeners();
    // }

    // final Map<String, String> _user = {};
    // _user["token"] = token;
    // _user["uid"] = uid;

    // // final result = await service.fetchProfile(_user);

    // // _userInfo = result;
    // _isLoading = false;
    // notifyListeners();

    return _userInfo;
  }

}