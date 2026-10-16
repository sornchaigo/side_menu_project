import 'dart:async'; // สำหรับจัดการข้อมูลแบบ async
import 'dart:convert'; // สำหรับจัดการข้อมูล JSON data

import 'package:flutter/foundation.dart'; // มีคำสั่งสำหรับจัดการข้อมูลอยู่ background
import 'package:http/http.dart'
    as http; // ดึงข้อมูลจัดการข้อมูลบนเครือข่าย internet

class Article {
  final int id;
  final int userId;
  final String title;
  final String body;

  Article({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // ส่วนของ name constructor ที่จะแปลง json string มาเป็น Article object
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  // สรัางฟังก์ชั่นดึงข้อมูล คืนค่ากลับมาเป็นข้อมูล Future ประเภท List ของ Article
  static Future<List<Article>> fetchArticle() async {
    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load article');
    }

    // 200 ขอข้อมูลสำเร็จ
    // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<Article>
    // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parseArticles
    // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
    return compute(parseArticles, response.body);
  }

  // ฟังก์ชั่นแปลงข้อมูล JSON String data เป็น เป็นข้อมูล List<Article>
  static List<Article> parseArticles(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Article>((json) => Article.fromJson(json)).toList();
  }
}
