import 'package:flutter/material.dart';
import 'package:flutter_aisa/forum.dart';
import 'package:flutter_aisa/poisson.dart';
import 'package:flutter_aisa/profil.dart';
import 'package:flutter_aisa/tabs.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const BottomTabsApp());

class BottomTabsApp extends StatelessWidget {
  const BottomTabsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomTabs(),
    );
  }
}

class BottomTabs extends StatefulWidget {
  const BottomTabs({super.key});

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    TabsSegment(),
    Poisson(),
    ForumPage(),
    PageProfil(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesome5Solid.fish),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
