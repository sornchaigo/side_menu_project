import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
  
// สร้างข้อมูล app state ชื่อ Counter ใช้งานร่วมกับ ChangeNotifier
class CounterModel with ChangeNotifier {
  int _count = 0; // กำหนดชนิดข้อมูล และค่าเริ่มต้น
  
  // กำหนด getter คือค่าจากตัวแปร _count
  int get count => _count;
  
  // กำหนดคำสั่ง และการทำงาน
  void increment() {
    _count++; // เพิ่มจำนวน
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลงข้อมูล
  }
  
  // กำหนดคำสั่ง และการทำงาน
  void reset() {
    _count = 0; // รีเซ็ตค่า
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลงข้อมูล
  }  
  
}

class Count extends StatelessWidget {
  const Count({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${context.watch<CounterModel>().count}',
      key: const Key('counterState'),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
