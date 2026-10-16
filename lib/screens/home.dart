import 'dart:math';
 
import 'package:flutter/material.dart';
   
class Home extends StatefulWidget {
    static const routeName = '/';
  
    const Home({Key? key}) : super(key: key);
   
    @override
    State<StatefulWidget> createState() {
        return _HomeState();
    }
}
   
class _HomeState extends State<Home> {
 
    // จำลองข้อมูล สร้างลิสรายการ 100 รายการ
    List<String> items = List<String>.generate(100, (i) => 'Item ${i+1}');
   
    @override
    void initState() {
      print("initState"); // สำหรับทดสอบ
      super.initState(); 
    }     
 
    void _refreshData(){
      setState(() {
        print("setState"); // สำหรับทดสอบ
        Random rng = Random(); // ข้อมูล Random
        int rd_number = rng.nextInt(20); // สุ่มค่าจาก 0 - 20
        print(rd_number); // สำหรับทดสอบ
        // สร้างลิสรายการใหม่
        items = List<String>.generate(rd_number, (i) => 'Item ${i+1}');
      });
    }
 
    @override
    Widget build(BuildContext context) {
        print("build");  // สำหรับทดสอบ
        return Scaffold(
            appBar: AppBar(
                title: Text('Home'),
            ),
            body: Column(
              children: [
                Container( // สร้างส่วน header ของลิสรายการ
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.withAlpha(100),
                //    borderRadius: BorderRadius.circular(8.0),
                  ),                  
                  child: Row(                  
                    children: [
                      Text('Total ${items.length} items'),
                    ],
                  ),
                ),
                Expanded(
                      child: items.length > 0 // กำหนดเงื่อนไขตรงนี้
                      ? ListView.separated( // กรณีมีรายการ แสดงปกติ
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text('${items[index]}'),
                                  );
                              },
                              separatorBuilder: (BuildContext context, int index) => const Divider(),                    
                        )
                      : const Center(child: Text('No items')), // กรณีไม่มีรายการ
                  ),
              ],
            ),
              floatingActionButton: FloatingActionButton(// ปุ่มสำหรับดึงข้อมูลใหม่
                  onPressed: _refreshData,
                  child: const Icon(Icons.refresh),
              ),
        );
    }
}