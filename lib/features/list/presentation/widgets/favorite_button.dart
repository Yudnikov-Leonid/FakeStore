import 'package:fake_store/features/list/domain/entity/store_item.dart';
import 'package:fake_store/features/list/presentation/pages/list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton(this._item, {required this.doRebuild, super.key});

  final StoreItem _item;
  final bool doRebuild;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite = widget._item.isFavorite;
  bool _isChanging = false;

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('favorites');
    return IconButton(
        onPressed: () async {
          if (_isChanging) return;
          _isChanging = true;
          if (_isFavorite) {
            await ref
                .child(
                    '${FirebaseAuth.instance.currentUser!.uid}${widget._item.id}')
                .remove();
          } else {
            await ref
                .child(
                    '${FirebaseAuth.instance.currentUser!.uid}${widget._item.id}')
                .set({
              'userId': FirebaseAuth.instance.currentUser!.uid,
              'id': widget._item.id
            });
          }
          ListPage.of(context)?.rebuild(widget.doRebuild);
          setState(() {
            _isChanging = false;
            _isFavorite = !_isFavorite;
          });
        },
        icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_outline));
  }
}
