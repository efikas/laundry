import 'package:meta/meta.dart';

class Service {
  // Id will be gotten from the database.
  // It's automatically generated & unique for every stored Fruit.
  int id;
  final String name;
  final int quantity;
  final int price;
  final String slug;
  final String image;

  Service({
    @required this.name,
    @required this.quantity,
    @required this.price,
    @required this.slug,
    @required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'slug': slug,
      'image': image,
    };
  }

  static Service fromMap(Map<String, dynamic> map) {
    return Service(
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      slug: map['slug'],
      image: map['image'],
    );
  }
}