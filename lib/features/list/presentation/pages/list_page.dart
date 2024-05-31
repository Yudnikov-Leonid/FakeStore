import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:fake_store/features/list/presentation/widgets/store_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  static ListPageState? of(BuildContext context) {
    return context.findAncestorStateOfType();
  }

  @override
  State<ListPage> createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  void rebuild(bool doRebuild) {
    setState(() {
      if (doRebuild) {
        _key = Key(DateTime.now().millisecondsSinceEpoch.toString());
      }
    });
  }

  Key _key = const Key('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fake store'),),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: _list()
      )),
    );
  }

  FirebaseAnimatedList _list() {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('items');
    return FirebaseAnimatedList(
      query: ref,
      key: _key,
      defaultChild: const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, snapshot, index, animation) {
        return FutureBuilder(
            future:
                _isFavorite(int.parse(snapshot.child('id').value.toString())),
            builder: (context, isFavorite) {
              if (isFavorite.hasData) {
                return StoreItemWidget(
                    StoreItem.fromSnapshot(snapshot, isFavorite.data!));
              } else {
                return const SizedBox();
              }
            });
      },
    );
  }

  Future<bool> _isFavorite(int id) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child('favorites/${FirebaseAuth.instance.currentUser!.uid}${id}');
    final data = await ref.once();
    return data.snapshot.exists;
  }
}
