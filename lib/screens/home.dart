import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import "../models/article.dart";

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var logger = Logger();

  // กำนหดตัวแปรข้อมูล articles
  late Future<List<Article>> articles;

  @override
  void initState() {
    logger.i("initState");
    super.initState();

    articles =
        Article.fetchArticle(); // ทำตามสัญญา กำหนดค่า โดยให้ไปดึงจากฟังก์ชั่น
  }

  void _refreshData() {
    setState(() {
      logger.i("setState");

      articles = Article.fetchArticle(); // โหลดข้อมูลใหม่
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build");

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: FutureBuilder<List<Article>>(
          future: articles,
          builder: (context, snapshot) {
            logger.i("builder"); // สำหรับทดสอบ
            logger.i(snapshot.connectionState);

            // กรณีสถานะเป็น waiting ยังไม่มีข้อมูล แสดงตัว loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              // กรณี error
              logger.e("Error:");
              logger.e(snapshot.error);
              return Text('${snapshot.error}');
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
                  // ส่วนของลิสรายการ
                  child:
                      snapshot.data!.length >
                          0 // กำหนดเงื่อนไขตรงนี้
                      ? ListView.separated(
                          // กรณีมีรายการ แสดงปกติ
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data![index].title),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        )
                      : const Center(
                          child: Text('No items'),
                        ), // กรณีไม่มีรายการ
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // ปุ่มสำหรับดึงข้อมูลใหม่
        onPressed: _refreshData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
