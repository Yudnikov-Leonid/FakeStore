import 'package:firebase_database/firebase_database.dart';

class ReviewItem {
  final int itemId;
  final double rating;
  final String userName;
  final String content;

  ReviewItem(
      {required this.itemId,
      required this.rating,
      required this.userName,
      required this.content});

  factory ReviewItem.fromDataSnapshot(DataSnapshot snapshot) {
    return ReviewItem(
        itemId: int.parse(snapshot.child('itemId').value.toString()),
        rating: double.parse(snapshot.child('rating').value.toString()),
        userName: snapshot.child('userName').value.toString(),
        content: snapshot.child('content').value.toString());
  }
}
