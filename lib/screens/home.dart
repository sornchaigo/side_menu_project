import 'dart:math';

import 'package:flutter/material.dart';

import '../models/article.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  // จำลองข้อมูล สร้างลิสรายการ 100 รายการ
  List<String> items = List<String>.generate(100, (i) => 'Item ${i + 1}');

  // กำหนดตัวแปรข้อมูล articles
  late Future<List<Article>> articles;

  @override
  void initState() {
    print("initState"); // สำหรับทดสอบ
    super.initState();

    // เรียกใช้ฟังก์ชั่น fetchArticle() เพื่อดึงข้อมูลจาก server
    articles = fetchArticle();
  }

  void _refreshData() {
    setState(() {
      print("setState"); // สำหรับทดสอบ
      Random rng = Random(); // ข้อมูล Random
      int rd_number = rng.nextInt(20); // สุ่มค่าจาก 0 - 20
      print(rd_number); // สำหรับทดสอบ
      // สร้างลิสรายการใหม่
      items = List<String>.generate(rd_number, (i) => 'Item ${i + 1}');

      articles = fetchArticle(); // โหลดข้อมูลใหม่
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build"); // สำหรับทดสอบ
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: FutureBuilder<List<Article>>(
        future: articles, // ข้อมูล Future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found.'));
          }

          return Text("Complete: ${snapshot.data!.length} articles loaded.");
        },
      ),
      floatingActionButton: FloatingActionButton(
        // ปุ่มสำหรับดึงข้อมูลใหม่
        onPressed: _refreshData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
