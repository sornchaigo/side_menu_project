import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import "../models/product.dart";
import 'products.dart';

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
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         Products(), // กำหนด PageRoute
                                        //     settings: RouteSettings(
                                        //       arguments: product, // ส่งค่าไปใน  arguments
                                        //     ),
                                        //   ),
                                        // );

                                        Navigator.of(context).push(_viewProduct(context, product));
                                      },
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

  // สร้างฟังก์ชั่น ที่คืนค่าเป็น route ของ object ฟังก์ชั่นนี้ มี context และ product เป็น parameter
  static Route<Object?> _viewProduct(BuildContext context, Product product) {
    return DialogRoute<void>(
      context: context,
      builder:
          // ใช้ arrow aฟังก์ชั่น
          (BuildContext context) =>
              // คืนค่าเป็น dismissible widget
              Dismissible(
                direction: DismissDirection.vertical, // เมื่อปัดลงในแนวตั้ง
                key: const Key('key'), // ต้องกำหนด key ใช้ค่าตามนี้ได้เลย
                onDismissed: (_) =>
                    Navigator.of(context).pop(), // ปัดลงเพื่อปิด
                child: Scaffold(
                  appBar: AppBar(
                    // เราใช้ appbar แต่จะให้แสดงแต่ปุ่มปิด
                    leading: IconButton(
                      // ใช้ไอคอนปุ่ม
                      onPressed: () {
                        // เมื่อกด
                        Navigator.of(context).pop(); //ปิดหน้านี้
                      },
                      icon: Icon(Icons.close, color: Colors.black),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                  ),
                  body: SingleChildScrollView(
                    //ใช้งาน widget นี้เพื่อป้องกัน error พื้นที่เกินขอบเขต
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(product.image), // แสดงรูป
                          SizedBox(height: 10.0),
                          Text(
                            product.title, // แสดงชื่อสินค้า
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: 5.0),
                          Text('Price: \$ ${product.price}'), // แสดงราคา
                          SizedBox(height: 10.0),
                          Text(
                            'Price: ${product.description}',
                          ), // แสดงรายละเอียด
                        ],
                      ),
                    ),
                  ),
                ),
              ),
    );
  }
}
