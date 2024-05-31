import 'package:firebase_database/firebase_database.dart';

class StoreItem {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final int price;
  final int oldPrice;
  final bool isFavorite;

  StoreItem(
      {required this.id,
      required this.title,
      required this.description,
      required this.rating,
      required this.imageUrl,
      required this.price,
      required this.oldPrice,
      required this.isFavorite});

  factory StoreItem.fromSnapshot(DataSnapshot snapshot, bool isFavorite) {
    return StoreItem(
      id: int.parse(snapshot.child('id').value.toString()),
      title: snapshot.child('title').value.toString(),
      description: snapshot.child('description').value.toString(),
      rating: double.parse(snapshot.child('rating').value.toString()),
      imageUrl: snapshot.child('imageUrl').value.toString(),
      price: int.parse(snapshot.child('price').value.toString()),
      oldPrice: int.parse(snapshot.child('oldPrice').value.toString()),
      isFavorite: isFavorite,
    );
  }
}
