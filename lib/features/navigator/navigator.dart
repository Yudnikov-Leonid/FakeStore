import 'package:fake_store/features/list/presentation/pages/list_page.dart';
import 'package:flutter/material.dart';

class StoreNavigator extends StatefulWidget {
  const StoreNavigator({super.key});

  @override
  State<StoreNavigator> createState() => _StoreNavigatorState();
}

class _StoreNavigatorState extends State<StoreNavigator> {
  int _index = 0;
  List<Widget> body = [
    ListPage(),
    Text('2'),
    Text('3'),
    Text('4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Navigator(onPopPage: (route, result) {
      return route.didPop(result);
    }, pages: [
      MaterialPage(
        child: Scaffold(
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      )
    ]);
  }
}
