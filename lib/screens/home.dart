import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import "../models/article.dart";
import "../models/user.dart";

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
  late List<User> users;

  @override
  void initState() {
    logger.i("initState");
    super.initState();

    // โหลดข้อมูล ใหม่ ผ่าน method fetch
    articles = Article.fetch();
    loadData();
  }

  void loadData() async {
    users = await User.fetch();
  }

  User _findUser(int userId) {
    // 2. Apply the .where() filter on the resulting List
    return users.where((user) => user.id == userId).first;
  }

  void _refreshData() {
    setState(() {
      logger.i("setState");

      articles = Article.fetch(); // โหลดข้อมูล Article ใหม่
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
                            User user = _findUser(snapshot.data![index].userId);
                            return ListTile(
                              title: Text(
                                snapshot.data![index].title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(snapshot.data![index].body),
                              trailing: Text("${user.name}"),
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
