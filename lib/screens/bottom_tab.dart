import 'package:flutter/material.dart';
import 'package:ristoply_app/screens/carrello.dart';
import 'package:ristoply_app/screens/home.dart';
import 'package:ristoply_app/screens/profilo.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
int _selectedIndex = 0;

void _selectPage(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

static const List<Widget> _pages = [
  Home(),
  Carrello(),
  Profilo(),
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromRGBO(39, 117, 104, 1),
        backgroundColor: Colors.white,
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrello',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profilo',
          ),
        ],
      ),
    );
  }
}
