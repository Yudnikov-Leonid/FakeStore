import 'package:fake_store/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('cart');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
                child: FirebaseAnimatedList(
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
                              int.parse(
                                  snapshot.child('count').value.toString()));
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
      ),
    );
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
