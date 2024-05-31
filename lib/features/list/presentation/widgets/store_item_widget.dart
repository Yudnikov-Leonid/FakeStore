import 'package:fake_store/features/details/presentation/pages/details_page.dart';
import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StoreItemWidget extends StatefulWidget {
  const StoreItemWidget(this._item, {super.key});

  final StoreItem _item;

  @override
  State<StoreItemWidget> createState() => _StoreItemWidgetState();
}

class _StoreItemWidgetState extends State<StoreItemWidget> {
  late bool _isFavorite = widget._item.isFavorite;

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('favorites');
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailsPage(widget._item)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(32)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget._item.imageUrl),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  '${widget._item.price.toString()}\$',
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget._item.oldPrice.toString()}\$',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 3,
                      decorationColor: Colors.grey,
                      fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "-${((widget._item.oldPrice - widget._item.price) / widget._item.oldPrice * 100).round()}%",
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget._item.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                Text(widget._item.rating.toString()),
                const Icon(
                  Icons.star,
                  size: 18,
                ),
                IconButton(
                    onPressed: () async {
                      if (_isFavorite) {
                        await ref
                            .child(
                                '${FirebaseAuth.instance.currentUser!.uid}${widget._item.id}')
                            .remove();
                      } else {
                        await ref
                            .child(
                                '${FirebaseAuth.instance.currentUser!.uid}${widget._item.id}')
                            .set({
                          'userId': FirebaseAuth.instance.currentUser!.uid,
                          'id': widget._item.id
                        });
                      }
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                    icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_outline))
              ],
            ),
            Text(
              widget._item.description,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
