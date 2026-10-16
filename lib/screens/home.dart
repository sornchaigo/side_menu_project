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

  // ตัว ScrollController สำหรับจัดการการ scroll ใน ListView
  final ScrollController _scrollController = ScrollController();

  // กำนหดตัวแปรข้อมูล articles
  late Future<List<Article>> articles;
  late List<User> users;

  @override
  void initState() {
    logger.i("initState");
    super.initState();

    // โหลดข้อมูล ใหม่ ผ่าน method fetch
    loadData();
    articles = Article.fetch();
  }

  void loadData() async {
    users = await User.fetch();
  }

  User _findUser(int userId) {
    // 2. Apply the .where() filter on the resulting List
    return users.where((user) => user.id == userId).first;
  }

  // void _refreshData() {
  //   setState(() {
  //     logger.i("setState");

  //     articles = Article.fetch(); // โหลดข้อมูล Article ใหม่
  //   });
  // }

  Future<void> _refresh() async {
    setState(() {
      articles = Article.fetch();
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
                  child: snapshot.data!.isNotEmpty
                      ? // กำหนดเงื่อนไขตรงนี้
                        RefreshIndicator(
                          onRefresh: _refresh,
                          child: ListView.separated(
                            // กำหนด controller ที่จะใช้งานร่วม
                            controller: _scrollController, 
                            // กรณีมีรายการ แสดงปกติ
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Article article = snapshot.data![index];
                              User user = _findUser(article.userId);

                              return Card(
                                // shape: BeveledRectangleBorder(
                                shape: RoundedRectangleBorder(
                                  // รูปแบบ
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    width: 2,
                                    color: Colors.blue,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                margin: const EdgeInsets.all(
                                  5.0,
                                ), // การเยื้องขอบ
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        article.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(article.body),
                                      trailing: Text("By ${user.name}"),
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        TextButton(
                                          child: const Text('Like'),
                                          onPressed: () {
                                            /* ... */
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        TextButton(
                                          child: const Text('Comment'),
                                          onPressed: () {
                                            /* ... */
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Container(
                                            color: Colors.green.withAlpha(50),
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              child: const Text('Share'),
                                              onPressed: () {
                                                /* ... */
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) => const Divider(),
                          ),
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
      // floatingActionButton: FloatingActionButton(
      //   // ปุ่มสำหรับดึงข้อมูลใหม่
      //   onPressed: _refreshData,
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
