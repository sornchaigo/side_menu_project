import 'package:flutter/material.dart';

class About extends StatefulWidget {
  static const routeName = '/about';

  const About({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AboutState();
  }
}

class _AboutState extends State<About> {
  // // จำลองข้อมูลที่จะได้ หรือจะเกิดในอนาคต
  // final Future<String> _calculation = Future<String>.delayed(
  //   const Duration(seconds: 5),
  //   // () => throw Exception("ข้อมูลไม่พร้อมใช้งาน"),
  //   () => 'Data Loaded',
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<String>(
              // กำหนดชนิดข้อมูล
              future: fetchData(), // ข้อมูล Future
              //builder: (BuildContext context, AsyncSnapshot snapshot) {
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // ถ้ากำลังรอข้อมูล
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  // ถ้ามี error
                  return Text('${snapshot.error}');
                }

                // ถ้าได้ค่าข้อมูลสุดท้าย
                return Text('Completed ${snapshot.data}');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    // จำลองการดึงข้อมูลจาก API
    final response = await Future.delayed(
      const Duration(seconds: 2),
      () => 'Data from API',
    );
    return response;
  }
}
