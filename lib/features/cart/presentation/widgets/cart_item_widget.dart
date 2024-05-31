import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  const CartWidget(this._item, this.count, {super.key});

  final StoreItem _item;
  final int count;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(6),
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
                color: Colors.amber,
              )
            ],
          ),
          Text(
            widget._item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: GestureDetector(
                  onTap: () async {
                    if (widget.count == 1) {
                      await _remove(widget._item.id);
                    } else {
                      await _changeCount(widget.count - 1, widget._item.id);
                      ;
                    }
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  width: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                    widget.count.toString(),
                    style: const TextStyle(color: Colors.black),
                  ))),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: GestureDetector(
                  onTap: () async {
                    await _changeCount(widget.count + 1, widget._item.id);
                    ;
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _changeCount(int newCount, int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('cart');
    ref
        .child("${FirebaseAuth.instance.currentUser!.uid}|${id.toString()}")
        .update({'count': newCount});
  }

  Future<void> _remove(int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('cart');
    ref
        .child("${FirebaseAuth.instance.currentUser!.uid}|${id.toString()}")
        .remove();
  }
}
