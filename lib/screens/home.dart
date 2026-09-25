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

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // กำหนดค่าเริ่มต้น
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static const List<Widget> _pageWidget = <Widget>[
    Text('Index 0: สวัสดี', style: TextStyle(fontFamily: "Takowasabi")),
    Text('Index 1: About'),
    Text('Index 2: Profile'),
    Text('Index 3: Contact'),
    Text('Index 4: Settings'),
  ];

  static const List<BottomNavigationBarItem> _menuBar =
      <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'สวัสดี'),
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

  void _showSnackBar(String text) {
    // เมื่อกดที่ปุ่ม

    // กำหนดรูปแบบการใช้งาน snackbar
    final snackBar3 = SnackBar(
      content: Row(
        // แสดงข้อมูลอื่นๆ นอกจากข้อความอย่างเดียว
        children: [
          Icon(Icons.info_rounded, color: Colors.yellow), // ใส่ไอคอน
          SizedBox(width: 10), // เพิ่มกล่องช่องว่าง
          Expanded(child: Text(text)),
        ],
      ),
      duration: const Duration(seconds: 3), // กำหนดเวลาแสดง 3 วินาที
      width: 300.0, // กำหนดความกว้่าง
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      action: SnackBarAction(
        label: 'ดูเพิ่มเติม',
        onPressed: () {
          // ทำคำสั่งถ้ากดที่ข้อความใน action
        },
      ),
    );

    // แสดงข้อความ snackbar โดยเรียกใช้งานผ่าน ScaffoldMessenger
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        bottom: TabBar(
          controller: _tabController, // กำหนดการเรียกใช้งาน TabController
          // ส่วนของ tab
          tabs: const [
            Tab(icon: Icon(Icons.feed), text: 'Tab 1'),
            Tab(icon: Icon(Icons.favorite_sharp), text: 'Tab 2'),
            Tab(icon: Icon(Icons.thumb_up), text: 'Tab 3'),
            Tab(icon: Icon(Icons.announcement), text: 'Tab 4'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // กำหนดการเรียกใช้งาน TabController
        // ส่วนของเนื้อหา tab
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Tab Home'),
                ElevatedButton(
                  // ปุ่มสำหรับทดสอบ
                  onPressed: () {
                    // เลื่อนไปยัง index 3 ซึ่งก็คือค่า index ของ tab ที่ 4
                    _tabController.animateTo(3);
                  },
                  child: const Text('Go to Tab 4'),
                ),
              ],
            ),
          ),
          const Center(child: Text('Tab Faverite')),
          const Center(child: Text('Tab Like')),
          const Center(child: Text('Tab Commnet')),
        ],
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
