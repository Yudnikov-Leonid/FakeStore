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
          const TextField(
            decoration: InputDecoration(hintText: 'Search') ,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              reverse: true,
              defaultChild: const Center(
                child: CircularProgressIndicator(),
              ),
              itemBuilder: (context, snapshot, index, animation) {
                print(123);
                final item = StoreItem(
                    title:  snapshot.child('title').value.toString(),
                    description:  snapshot.child('description').value.toString(),
                    rating:  double.parse(snapshot.child('rating').value.toString()),
                    imageUrl:  snapshot.child('imageUrl').value.toString(),
                    price: int.parse(snapshot.child('price').value.toString()),
                    oldPrice: int.parse(snapshot.child('oldPrice').value.toString()),
                    );
                return StoreItemWidget(item);
              },
            ),
          )
        ],
      ),
    ));
  }
}
