import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:laundry/services/datas.dart';

class Services  {
    BaseOptions options = new BaseOptions(
      baseUrl: "http://0.0.0.0:8080/mobile/",
      // baseUrl: "https://laundry.app/mobile/",
      headers: requestHeaders,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    Dio dio = null;
    
    Services() {
      dio = new Dio(options);
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
          // await  _authDb.insert(
          //   Auth(isAuthenticated: true, uid: responseJson["uid"], token: responseJson["remember_token"])
          // );

          // //save user information to database and update store
          // await _userDb.insert(
          //   User.fromMap(responseJson)
          // );

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

        if(responseJson.containsKey("uid")){
          // await  _authDb.insert(
          //   Auth(isAuthenticated: true, uid: responseJson["uid"], token: responseJson["remember_token"])
          // );
        }

        print(responseJson);

        return responseJson;
      } catch (error) {
        print(error.toString());

        return {};
      }
    }




    // Future submitQuiz(Map<String, String> quizInfo) async {
    //   try {

    //     final response = await dio.post("submitanswer", data: {
    //         "device": "mobile",
    //         ...quizInfo
    //     });

    //     Map<String, dynamic> responseJson = json.decode(response.toString());

    //     if(responseJson.containsKey("uid")){
    //       // await  _authDb.insert(
    //       //   Auth(isAuthenticated: true, uid: responseJson["uid"], token: responseJson["remember_token"])
    //       // );
    //     }

    //     return responseJson;
    //   } catch (error) {
    //     print(error.toString());

    //     return null;
    //   }
    // }
    
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

    // Future fetchTestimony(Map<String, String> userInfo) async {
    //   try {

    //     final response = await dio.post("testimony", data: {
    //       "token": userInfo["token"],
    //       "uid": userInfo["uid"]
    //     });

    //    final responseJson = json.decode(response.toString())["data"];

    //     List<Map<String, dynamic>> responseList = [];

    //     responseJson.forEach((dynamic value) {
    //       responseList.add(Map<String, dynamic>.from(value));
    //     });

    //     return responseList;

    //   } catch (error) {
    //     print(error.toString());

    //     return null;
    //   }
    // }

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