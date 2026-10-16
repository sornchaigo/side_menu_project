import 'dart:async'; // สำหรับจัดการข้อมูลแบบ async
import 'dart:convert'; // สำหรับจัดการข้อมูล JSON data

import 'package:flutter/foundation.dart'; // มีคำสั่งสำหรับจัดการข้อมูลอยู่ background
import 'package:http/http.dart'
    as http; // ดึงข้อมูลจัดการข้อมูลบนเครือข่าย internet

class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  // ส่วนของ name constructor ที่จะแปลง json string มาเป็น User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  // สรัางฟังก์ชั่นดึงข้อมูล คืนค่ากลับมาเป็นข้อมูล Future ประเภท List ของ User
  static Future<List<User>> fetch() async {
    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load article');
    }

    // 200 ขอข้อมูลสำเร็จ
    // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<User>
    // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parse
    // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
    return compute(parse, response.body);
  }

  // ฟังก์ชั่นแปลงข้อมูล JSON String data เป็น เป็นข้อมูล List<User>
  static List<User> parse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
