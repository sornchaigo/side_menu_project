import 'dart:async'; // สำหรับจัดการข้อมูลแบบ async
import 'dart:convert'; // สำหรับจัดการข้อมูล JSON data

import 'package:flutter/foundation.dart'; // มีคำสั่งสำหรับจัดการข้อมูลอยู่ background
import 'package:http/http.dart' as http;

class Article {
  final int userId;
  final int id;
  final String title;
  final String body;

  Article({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // ส่วนของ name constructor ที่จะแปลง json string มาเป็น Article object
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// สรัางฟังก์ชั่นดึงข้อมูล คืนค่ากลับมาเป็นข้อมูล Future ประเภท List ของ Article
Future<List<Article>> fetchArticle() async {
  // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );

  // เมื่อมีข้อมูลกลับมา
  if (response.statusCode == 200) {
    // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<Article
    // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parseArticles
    // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
    return compute(parseArticles, response.body);
  } else {
    // กรณี error
    throw Exception('Failed to load article');
  }
}

// ฟังก์ชั่นแปลงข้อมูล JSON String data เป็น เป็นข้อมูล List<Article>
List<Article> parseArticles(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Article>((json) => Article.fromJson(json)).toList();
}
