import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddToCartWidget extends StatefulWidget {
  const AddToCartWidget(this._itemId, {super.key});

  final int _itemId;

  @override
  State<AddToCartWidget> createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget> {
  late int count;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getCount(widget._itemId),
        builder: (context, sn) {
          if (sn.hasData) {
            if (sn.data! == 0) {
              return ElevatedButton(
                  onPressed: () async {
                    await _addToCart(widget._itemId);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(500, 50)),
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(color: Colors.white),
                  ));
            } else {
              return Row(
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: const Size(240, 50)),
                      child: const Text(
                        'Already in cart',
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: GestureDetector(
                      onTap: () async {
                        if (count == 1) {
                          await _remove(widget._itemId);
                        } else {
                          await _changeCount(count - 1, widget._itemId);
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        count.toString(),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: GestureDetector(
                      onTap: () async {
                        await _changeCount(count + 1, widget._itemId);
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
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<void> _remove(int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('cart');
    ref
        .child("${FirebaseAuth.instance.currentUser!.uid}|${id.toString()}")
        .remove();
  }

  Future<void> _addToCart(int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('cart');
    await ref
        .child('${FirebaseAuth.instance.currentUser!.uid}|${id.toString()}')
        .set({
      'id': id,
      'count': 1,
      'userId': FirebaseAuth.instance.currentUser!.uid
    });
  }

//TODO dry in cart_item_widget
  Future<void> _changeCount(int newCount, int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('cart');
    await ref
        .child("${FirebaseAuth.instance.currentUser!.uid}|${id.toString()}")
        .update({'count': newCount});
  }

  Future<int> _getCount(int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('cart');
    final data = await ref.get();
    final item = data.children
        .where((sn) =>
            sn.child('userId').value.toString() ==
                FirebaseAuth.instance.currentUser!.uid &&
            int.parse(sn.child('id').value.toString()) == id)
        .firstOrNull;
    if (item != null) {
      count = int.parse(item.child('count').value.toString());
      return count;
    } else {
      count = 0;
      return 0;
    }
  }
}
