import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:fake_store/features/list/presentation/widgets/store_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('items');
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fake store',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: const Center(
                child: CircularProgressIndicator(),
              ),
              itemBuilder: (context, snapshot, index, animation) {
                print(123);
                final item = StoreItem(
                    snapshot.child('title').value.toString(),
                    snapshot.child('description').value.toString(),
                    snapshot.child('imageUrl').value.toString());
                return StoreItemWidget(item);
              },
            ),
          )
        ],
      ),
    ));
  }
}
