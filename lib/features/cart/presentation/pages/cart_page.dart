import 'package:fake_store/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('cart');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: FirebaseAnimatedList(
                  defaultChild: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  padding: const EdgeInsets.only(bottom: 70),
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    if (snapshot.child('userId').value.toString() ==
                        FirebaseAuth.instance.currentUser!.uid) {
                      return FutureBuilder(
                          future: _getItem(
                              int.parse(snapshot.child('id').value.toString())),
                          builder: (context, sn) {
                            if (sn.hasData) {
                              return CartWidget(
                                  sn.data!,
                                  int.parse(snapshot
                                      .child('count')
                                      .value
                                      .toString()));
                            } else {
                              return const SizedBox();
                            }
                          });
                    } else {
                      return const SizedBox();
                    }
                  },
                ))
              ],
            ),
            FutureBuilder(
                future: _getPrice(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        margin: const EdgeInsets.only(bottom: 6),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey.shade200),
                        child: Row(
                          children: [
                            Text(
                              '${snapshot.data!.$1}\$',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${snapshot.data!.$2}\$',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 3,
                                  decorationColor: Colors.grey,
                                  fontSize: 18),
                            ),
                            const Expanded(child: SizedBox()),
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    fixedSize: const Size(120, 20)),
                                child: const Text(
                                  'Pay',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<(int, int)> _getPrice() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('cart');
    final data = await ref.get();
    final list = data.children.where((e) =>
        e.child('userId').value.toString() ==
        FirebaseAuth.instance.currentUser!.uid).toList();
    int price = 0;
    int oldPrice = 0;
    for (int i = 0; i < list.length; i++) {
      final item = await _getItem(int.parse(list[i].child('id').value.toString()));
      price += item.price * int.parse(list[i].child('count').value.toString());
      oldPrice += item.oldPrice * int.parse(list[i].child('count').value.toString());
    }
    return (price, oldPrice);
  }

  Future<StoreItem> _getItem(int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('items');
    final data = await ref.get();
    return StoreItem.fromSnapshot(
        data.children
            .where((sn) => int.parse(sn.child('id').value.toString()) == id)
            .first,
        false);
  }
}
