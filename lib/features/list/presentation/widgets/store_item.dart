import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:flutter/material.dart';

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget(this._item, {super.key});

  final StoreItem _item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(32)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(_item.imageUrl),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                _item.price.toString(),
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(width: 10,),
              Text(
                _item.oldPrice.toString(),
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
                "-${((_item.oldPrice - _item.price) / _item.oldPrice * 100).round()}%",
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
                  _item.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              Text(_item.rating.toString()),
              const Icon(
                Icons.star,
                size: 18,
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_outline))
            ],
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
