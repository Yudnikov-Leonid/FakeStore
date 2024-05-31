import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:flutter/material.dart';

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget(this._item, {super.key});

  final StoreItem _item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(_item.imageUrl),
          Text(
            _item.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Text(
            _item.description,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
