import 'package:meta/meta.dart';

class User {
  // Id will be gotten from the database.
  // It's automatically generated & unique for every stored Fruit.
  int id;

  final String email;
  final String uid;
  final String fullname;
  final String phone;
  final String address;
  final String image;
  // final String user_type;
  // final String remember_token;
  // final String last_question_id;

  User({
    @required this.email,
    @required this.uid,
    @required this.fullname,
    @required this.phone,
    @required this.address,
    @required this.image,
    // @required this.user_type,
    // @required this.remember_token,
    // @required this.last_question_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'fullname': fullname,
      'phone': phone,
      'address': address,
      'image': image,
      // 'user_type': user_type,
      // 'remember_token': remember_token,
      // 'last_question_id': last_question_id,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      uid: map['uid'],
      fullname: map['fullname'],
      phone: map['phone'],
      address: map['address'],
      image: map['image'],
      // user_type: map['user_type'],
      // remember_token: map['remember_token'],
      // last_question_id: map['last_question_id'],
    );
  }
}