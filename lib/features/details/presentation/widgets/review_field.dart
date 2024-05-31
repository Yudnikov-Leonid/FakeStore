import 'package:fake_store/features/details/presentation/pages/details_page.dart';
import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReviewField extends StatefulWidget {
  const ReviewField(this._item, {required this.ratings, super.key});

  final StoreItem _item;
  final List<double> ratings;

  @override
  State<ReviewField> createState() => _ReviewFieldState();
}

class _ReviewFieldState extends State<ReviewField> {
  int _rating = 0;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DatabaseReference reviewsRef =
        FirebaseDatabase.instance.ref().child('reviews');
    DatabaseReference itemsRef = FirebaseDatabase.instance.ref().child('items');
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _starButton(1),
            _starButton(2),
            _starButton(3),
            _starButton(4),
            _starButton(5),
          ],
        ),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Review'),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () async {
              if (_rating != 0) {
                await reviewsRef
                    .child(
                        '${FirebaseAuth.instance.currentUser!.uid}|${widget._item.id}')
                    .set({
                  'itemId': widget._item.id,
                  'rating': _rating,
                  'userId': FirebaseAuth.instance.currentUser!.uid,
                  'userName':
                      FirebaseAuth.instance.currentUser!.displayName?.isEmpty ??
                              true
                          ? 'Unknown'
                          : FirebaseAuth.instance.currentUser!.displayName,
                  'content': _controller.text.trim()
                });
                final rating =
                    (widget.ratings.fold(0.0, (a, b) => a + b) + _rating) /
                        (widget.ratings.length + 1);
                await itemsRef
                    .child(widget._item.id.toString())
                    .update({'rating': (rating * 100).round() / 100});
                context
                    .findAncestorStateOfType<DetailsPageState>()
                    ?.setState(() {});
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              'Add review',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  Widget _starButton(int number) {
    return IconButton(
        onPressed: () {
          setState(() {
            _rating = number;
          });
        },
        icon: Icon(
          Icons.star,
          color: _rating >= number ? Colors.amber : Colors.grey,
          size: 40,
        ));
  }
}
