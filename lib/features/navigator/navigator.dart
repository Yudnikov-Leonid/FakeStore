import 'package:fake_store/features/cart/presentation/pages/cart_page.dart';
import 'package:fake_store/features/favorites/presentation/favorite_page.dart';
import 'package:fake_store/features/list/presentation/pages/list_page.dart';
import 'package:fake_store/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

class StoreNavigator extends StatefulWidget {
  const StoreNavigator({super.key});

  @override
  State<StoreNavigator> createState() => StoreNavigatorState();
}

class StoreNavigatorState extends State<StoreNavigator> {
  int _index = 0;
  List<Widget> body = const [
    ListPage(),
    FavoritePage(),
    CartPage(),
    ProfilePage()
  ];

  static StoreNavigatorState? of(BuildContext context) {
    return context.findAncestorStateOfType();
  }

  void moveTo(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int newIndex) {
          setState(() {
            _index = newIndex;
          });
        },
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Store'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
