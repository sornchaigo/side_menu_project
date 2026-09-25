import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/sidemenu.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _pageWidget = <Widget>[
    Text('Index 0: Home'),
    Text('Index 1: About'),
    Text('Index 2: Profile'),
    Text('Index 3: Contact'),
    Text('Index 4: Settings'),
  ];

  static const List<BottomNavigationBarItem> _menuBar =
      <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_travel),
          label: 'Contact',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_pageWidget.elementAt(_selectedIndex)],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,

        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.blue,

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
