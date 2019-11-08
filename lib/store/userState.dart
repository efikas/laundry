import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:laundry/models/UserModel.dart';
import 'package:laundry/services/services.dart';

class UserState extends ChangeNotifier  {

  Services service = new Services();
  Map<String, dynamic> _userInfo = {
    "uid": "36af49efb9c40a88d5f56b9",
    "fullname": "Fullname",
    "email": "emial@email.com",
    "phone": "0808000000",
    "address": "Abuja, Nigeria",
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

  Future<dynamic> updateProfile(Map<String,String> _userCredentials) async {
    _isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic> response = await service.updateProfile(_userCredentials);

      if(response != null && response.containsKey("uid")) {
        _isLoading = false;

        this.getProfileInfo = User.fromMap({
          ...response,
          "image": response["full_image_url"]
        }).toMap();
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

  Future<dynamic> uploadImage(String uid, File image, String name) async {

    Map<String, dynamic> response = await service.uploadImage(uid, image, name);

    if(response != null && response.containsKey("uid")){
      this.getProfileInfo = User.fromMap({
        ...response,
        "image": response["full_image_url"]
      }).toMap();

      notifyListeners();
    }
    return response;
  } 

}