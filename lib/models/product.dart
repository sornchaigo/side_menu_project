import 'dart:async'; // สำหรับจัดการข้อมูลแบบ async
import 'dart:convert'; // สำหรับจัดการข้อมูล JSON data

import 'package:flutter/foundation.dart'; // มีคำสั่งสำหรับจัดการข้อมูลอยู่ background
import 'package:http/http.dart'
    as http; // ดึงข้อมูลจัดการข้อมูลบนเครือข่าย internet

class Product {
  static final String url = 'https://fakestoreapi.com/products';

  int id;
  String title;
  num price;
  String description;
  String category;
  String image;

  Rating? rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating
  });

  // ส่วนของ name constructor ที่จะแปลง json string มาเป็น Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image:  json['image'],
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null
    );
  }

  // สรัางฟังก์ชั่นดึงข้อมูล คืนค่ากลับมาเป็นข้อมูล Future ประเภท List ของ Product
  static Future<List<Product>> fetch() async {
    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load Product');
    }

    // 200 ขอข้อมูลสำเร็จ
    // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<Product>
    // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parse
    // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
    return compute(parse, response.body);
  }

  // ฟังก์ชั่นแปลงข้อมูล JSON String data เป็น เป็นข้อมูล List<Product>
  static List<Product> parse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}

class Rating {
  num? rate;
  int? count;
 
  Rating({
    this.rate, 
    this.count});
 
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'],
      count: json['count']
    );
  }
 
}