import 'package:meta/meta.dart';

class Service {
  // Id will be gotten from the database.
  // It's automatically generated & unique for every stored Fruit.
  int id;
  final String key;
  final int quantity;
  final String price;
  final String slug;
  final String image;

  Service({
    @required this.key,
    @required this.quantity,
    @required this.price,
    @required this.slug,
    @required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'quantity': quantity,
      'price': price,
      'slug': slug,
      'image': image,
    };
  }

  static Service fromMap(Map<String, dynamic> map) {
    return Service(
      key: map['key'],
      quantity: map['quantity'],
      price: map['price'],
      slug: map['slug'],
      image: map['image'],
    );
  }
}