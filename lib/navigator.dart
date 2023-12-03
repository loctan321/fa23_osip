
import 'package:flutter/material.dart';
import 'package:optimizing_stock_investment_portfolio/screens/forum_screen.dart';
import 'package:optimizing_stock_investment_portfolio/screens/home/home_screen.dart';
import 'package:optimizing_stock_investment_portfolio/screens/profile_screen.dart';
import 'package:optimizing_stock_investment_portfolio/screens/wishlist_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => __MainNavigatorStateState();
}

class __MainNavigatorStateState extends State<MainNavigation> {
// Current Index var
int  _selectedIndex1 =0 ;

 int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
      final   List<Widget> _screens = <Widget>[
      HomeScreen(),
      const ForumScreen(),
      const  WishlistScreen(),
     ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Whishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
  }
