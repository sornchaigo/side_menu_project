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
  // กำหนดตัวแปรข้อมูล articles
  late Future<List<Article>> articles;

  @override
  void initState() {
    print("initState"); // สำหรับทดสอบ
    super.initState();

    // เรียกใช้ฟังก์ชั่น fetchArticle() เพื่อดึงข้อมูลจาก server
    articles = Article.fetch();
  }

  void _refreshData() {
    setState(() {
      print("setState"); // สำหรับทดสอบ
      articles = Article.fetch(); // โหลดข้อมูลใหม่
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

          return Column(
            children: [
              Container(
                // สร้างส่วน header ของลิสรายการ
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: Colors.teal.withAlpha(100)),
                child: Row(
                  children: [
                    Text(
                      'Total ${snapshot.data!.length} items',
                    ), // แสดงจำนวนรายการ
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final article = snapshot.data![index];
                    return ListTile(
                      title: Text('${article.id}: ${article.title}'),
                      subtitle: Text(article.body),
                      trailing: Text('User ID: ${article.userId}'),
                    );
                  },
                ),
              ),
            ],
          );
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
