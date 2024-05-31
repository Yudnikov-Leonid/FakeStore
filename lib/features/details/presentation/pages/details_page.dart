import 'package:fake_store/features/details/domain/entity/review.dart';
import 'package:fake_store/features/details/presentation/widgets/add_to_cart.dart';
import 'package:fake_store/features/details/presentation/widgets/review_field.dart';
import 'package:fake_store/features/details/presentation/widgets/review_widget.dart';
import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:fake_store/features/list/presentation/widgets/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(this._item, {super.key});

  final StoreItem _item;

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(widget._item.imageUrl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget._item.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    FavoriteButton(
                      widget._item,
                      doRebuild: true,
                    )
                  ],
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '${widget._item.price.toString()}\$',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget._item.oldPrice.toString()}\$',
                        style: const TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3,
                            decorationColor: Colors.grey,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AddToCartWidget(widget._item.id),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  widget._item.description,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(
                  height: 60,
                ),
                FutureBuilder(
                    future: _getReviews(widget._item.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Column(
                          children: [
                            Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(snapshot.data!.$3.toString())
                                    ],
                                  ),
                                  Text(
                                    snapshot.data!.$1.length == 1
                                        ? '${snapshot.data!.$1.length} review'
                                        : '${snapshot.data!.$1.length} reviews',
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            snapshot.data!.$2
                                ? const SizedBox(
                                    child:
                                        Text('You have already left a review'),
                                  )
                                : ReviewField(widget._item,
                                    ratings: snapshot.data!.$1
                                        .map((e) => e.rating)
                                        .toList()),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.$1.length,
                                itemBuilder: (context, index) {
                                  return ReviewWidget(snapshot.data!.$1[index]);
                                }),
                          ],
                        );
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<double> _getRating(int itemId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('items');
    final data = await ref.get();
    return double.parse(data.children
        .where((sn) => int.parse(sn.child('id').value.toString()) == itemId)
        .first
        .child('rating')
        .value
        .toString());
  }

  Future<(List<ReviewItem>, bool, double)> _getReviews(int itemId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('reviews');
    final data = await ref.get();
    bool isMy = false;
    final rating = await _getRating(itemId);
    if (data.exists) {
      final list = data.children.map((sn) {
        if (sn.child('userId').value.toString() ==
                FirebaseAuth.instance.currentUser!.uid &&
            int.parse(sn.child('itemId').value.toString()) == itemId) {
          isMy = true;
        }
        return ReviewItem.fromDataSnapshot(sn);
      });
      return (list.where((e) => e.itemId == itemId).toList(), isMy, rating);
    } else {
      return (<ReviewItem>[], false, 0.0);
    }
  }
}
