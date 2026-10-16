import 'package:flutter/material.dart';

import '../models/product.dart';

class Products extends StatefulWidget {
  static const routeName = '/producs';

  const Products({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductsState();
  }
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    // รับค่า arguments ที่ส่งมาใช้งาน
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
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
              Text('Price: ${product.description}'), // แสดงรายละเอียด
            ],
          ),
        ),
      ),
    );
  }
}
