import 'package:fake_store/features/details/domain/entity/review.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget(this._item, {super.key});

  final ReviewItem _item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _item.userName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Text(_item.rating.toString())
          ],
        ),
        Text(_item.content, style: const TextStyle(),),
        const SizedBox(height: 10,)
      ],
    );
  }
}
