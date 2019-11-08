import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:laundry/database/AuthDb.dart';
import 'package:laundry/database/AppDb.dart';
import 'package:laundry/models/UserModel.dart';
import 'package:laundry/services/datas.dart';

// MAIL_USERNAME=2zsVvVRcR22atnrxKNECWg
// MAIL_PASSWORD=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

class Services  {
    BaseOptions options = new BaseOptions(
      // baseUrl: "http://0.0.0.0:8080/mobile/",
      // baseUrl: "http://laundry.app/mobile/",
      // baseUrl: "http://firstmobilelaundry.efikas.com.ng/mobile/",
      baseUrl: "https://krystal-klene.com/mobile/",
      headers: requestHeaders,
      // connectTimeout: 5000,
      // receiveTimeout: 5000,
    );
    Dio dio = null;
    AppDb _appDb;
    AuthDb _authDb;
    
    Services() {
      dio = new Dio(options);
      _appDb = new AppDb();
      _authDb = new AuthDb();
    }

    Future authenticate(Map<String, String> userInfo) async {
      try {

        final response = await dio.post("mobilelogin", data: {
            "device": "mobile",
            "email": userInfo["email"],
            "password": userInfo["password"]
        });

        Map<String, dynamic> responseJson = json.decode(response.toString());

        if(responseJson.containsKey("uid")){
          ///update user authentication on Db
          await  _appDb.store("auth", {
            "isAuthenticated": true,
            "token": responseJson["remember_token"],
            "uid": responseJson["uid"],
          });
          
          //save user information to database and update store
          await _appDb.store("user", {...responseJson,"image": responseJson["full_image_url"]});

        }

        return responseJson;
      } catch (error) {
        print(error.toString());

        return null;
      }
    }

    Future register(Map<String, String> userInfo) async {
      try {

        final response = await dio.post("mobileregister", data: {
            "device": "mobile",
            ...userInfo
        });

        Map<String, dynamic> responseJson = json.decode(response.toString());

        return responseJson;
      } catch (error) {
        print(error.toString());

        return {};
      }
    }

    Future forgotPassword(String email) async {
      try {
        final response = await dio.post("gentemppassword", data: {
            "device": "mobile",
            "email": email,
        });

        Map<String, dynamic> responseJson = json.decode(response.toString());

        return responseJson;
      } catch (error) {
        print(error.toString());

        return null;
      }
    }


    Future getServices() async {
      /// get services from server
      try {
        final response = await dio.get("services");
        Map<String, dynamic> responseJson = json.decode(response.toString());

        if(responseJson.containsKey("services")) return responseJson["services"];
      } catch (error) {
        print(error.toString());

        return null;
      }
    }
    
    Future updateProfile(Map<String, String> userInfo) async {
      try {
        final response = await dio.post("mobileregister", data: {
            "device": "mobile",
            ...userInfo
        });

        Map<String, dynamic> responseJson = json.decode(response.toString());

        if(responseJson.containsKey("uid")){
          await _appDb.store("user", {...responseJson,"image": responseJson["full_image_url"]});
        }

        return responseJson;
      } catch (error) {
        print(error.toString());

        return {};
      }
    }




    // Future fetchProfile(Map<String, String> userInfo) async {
    //     try {
    //       final response = await dio.post("profile", data: {
    //           "token": userInfo["token"],
    //           "uid": userInfo["uid"]
    //       });

    //       Map<String, dynamic> responseJson = json.decode(response.toString())["data"];

    //       if(responseJson.containsKey("uid")) {
    //         //save user information to database and update store
    //         await _userDb.insert(User.fromMap(responseJson));
    //       }
    //       return responseJson;

    //     } catch (error) {
    //       print(error.toString());

    //       return null;
    //     }
    // }

    Future sendPickupRequest(Map<String, dynamic> pickupInfo) async {
      try {

        final response = await dio.post("sendpickuprequest", data: {
          "device": "mobile",
          ...pickupInfo
        });

       final responseJson = json.decode(response.toString());

        Map<String, dynamic> responseMap = Map<String, dynamic>.from(responseJson);
        if(responseMap.containsKey("id")){
          return responseMap;
        }
      } catch (error) {
        print(error.toString());
      }

      return null;
    }

    Future uploadImage(String uid, File image, String name) async {
      try {

        final response = await dio.post("mobileimageupload", data: {
          "device": "mobile",
          "uid": uid,
          "image": base64Encode(image.readAsBytesSync())
        });

        dynamic responseJson = json.decode(response.toString());

        if(responseJson.containsKey("uid")){
          await _appDb.store("user", {...responseJson,"image": responseJson["full_image_url"]});
        }

        return responseJson;
      } catch (error) {
        print(error.toString());

        return null;
      }
    }

  }