import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:fake_store/features/list/presentation/widgets/store_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child('favorites')
        .ref;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SafeArea(
          child: FirebaseAnimatedList(
        query: ref,
        itemBuilder: (context, snapshot, animation, index) {
          final userId = snapshot.child('userId').value.toString();
          if (userId != FirebaseAuth.instance.currentUser!.uid) {
            return const SizedBox();
          }
          final id = int.parse(snapshot.child('id').value.toString());
          print('id: $id');
          return FutureBuilder(
              future: _getItem(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return StoreItemWidget(snapshot.data!);
                } else {
                  return const SizedBox();
                }
              });
        },
      )),
    );
  }

  Future<StoreItem> _getItem(int id) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child('items')
        .orderByChild('id')
        .equalTo(id)
        .ref;
    final snapshot = await ref.get();
    return StoreItem.fromSnapshot(snapshot.children.first);
  }
}
