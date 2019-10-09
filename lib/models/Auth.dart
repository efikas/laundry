import 'package:meta/meta.dart';

class Auth {
  final bool isAuthenticated;
  final String uid;
  final String token;

  Auth({
    @required this.isAuthenticated,
    @required this.uid,
    @required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'isAuthenticated': isAuthenticated,
      'uid': uid,
      'token': token,
    };
  }

  static Auth fromMap(Map<String, dynamic> map) {
    return Auth(
      isAuthenticated: map['isAuthenticated'],
      uid: map['uid'],
      token: map['token'],
    );
  }
}