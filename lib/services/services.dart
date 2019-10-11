import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:laundry/database/AuthDb.dart';
import 'package:laundry/database/UserDb.dart';
import 'package:laundry/models/UserModel.dart';
import 'package:laundry/services/datas.dart';

class Services  {
    BaseOptions options = new BaseOptions(
      // baseUrl: "http://0.0.0.0:8080/mobile/",
      baseUrl: "http://laundry.app/mobile/",
      headers: requestHeaders,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    Dio dio = null;
    UserDb _userDb;
    AuthDb _authDb;
    
    Services() {
      dio = new Dio(options);
      _userDb = new UserDb();
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
          await  _authDb.store("isAuthenticated", true);

          //save user information to database and update store
          await _userDb.insert(
            User.fromMap(responseJson)
          );

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

        // if(responseJson.containsKey("uid")){
        //   await  _authDb.store("isAuthenticated", true,);
        // }

        return responseJson;
      } catch (error) {
        print(error.toString());

        return {};
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
          // ...pickupInfo
        });
        print(response);

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

    // Future fetchAbout(Map<String, String> userInfo) async {
    //   try {

    //     final response = await dio.post("abouts", data: {
    //       "token": userInfo["token"],
    //       "uid": userInfo["uid"]
    //     });

    //     List<dynamic> responseJson = json.decode(response.toString())["data"];
    //     List<Map<String, dynamic>> responseList = [];

    //     responseJson.forEach((dynamic value) {
    //       responseList.add(Map<String, dynamic>.from(value));
    //     });

    //     if(responseList.length > 0) {
    //       //save about information to database and update store
    //       List<About> _map = [];
    //       responseList.forEach((about) {
    //         //TODO:: resolve the data storage saving issue
    //       //  _map.add(About.fromMap(about));
    //       });

    //       await _aboutDb.insert({"about": _map});
    //     }
    //     return responseList;

    //   } catch (error) {
    //     print(error.toString());

    //     return null;
    //   }
    // }

  }