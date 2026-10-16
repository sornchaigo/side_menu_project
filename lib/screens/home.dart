import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import "../models/product.dart";

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final logger = Logger();

  // กำหนดตัวแปรข้อมูล products
  late Future<List<Product>> products;

  // ตัว ScrollController สำหรับจัดการการ scroll ใน ListView
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    products = Product.fetch();
  }

  Future<void> _refresh() async {
    setState(() {
      products = Product.fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build");

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // กรณี error
              return Text('${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              // กรณีสถานะเป็น waiting ยังไม่มีข้อมูล แสดงตัว loading
              return const RefreshProgressIndicator();
            }

            return Column(
              children: [
                Container(
                  // สร้างส่วน header ของลิสรายการ
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.withAlpha(100),
                  ),
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
                      snapshot
                          .data!
                          .isNotEmpty // กำหนดเงื่อนไขตรงนี้
                      ? RefreshIndicator(
                          onRefresh: _refresh,
                          child: ListView.separated(
                            // กรณีมีรายการ แสดงปกติ
                            controller: _scrollController, // กำนหนด controller ที่จะใช้งานร่วม
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Product product = snapshot.data![index];

                              Widget card; // สร้างเป็นตัวแปร
                              card = Card(
                                // การเยื้องขอบ
                                margin: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Image.network(
                                        product.image,
                                        width: 100.0,
                                      ),
                                      title: Text(product.title),
                                      subtitle: Text(
                                        'Price: \$${product.price}',
                                      ),
                                      trailing: Icon(Icons.more_vert),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              );
                              return card;
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) => const SizedBox(),
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
    );
  }
}
