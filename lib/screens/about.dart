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

  // // จำลองข้อมูล stream
  // final Stream<int> _bids = (() async* {
  //   await Future<void>.delayed(const Duration(seconds: 3));
  //   yield 1;
  //   await Future<void>.delayed(const Duration(seconds: 3));
  //   // yield 2;
  //   throw Exception('Intentional exception');
  //   await Future<void>.delayed(const Duration(seconds: 3));
  //   yield 3;
  //   await Future<void>.delayed(const Duration(seconds: 3));
  // })();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
              // ชนิดข้อมูล Stream
              stream: _bidStream(), // ข้อมูล Stream
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                print("builder"); // สำหรับทดสอบ
                print(snapshot.connectionState); // สำหรับทดสอบ
                List<Widget> children;
                // กำหนดตัวแปร สำหรับเก็บ widget ที่จะคืนค่ากลับ
                if (snapshot.hasError) {
                  print("snapshot.hasError"); // สำหรับทดสอบ
                  print(snapshot.stackTrace); // สำหรับทดสอบ
                  // กรณี error
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 8),
                    //   child: Text('Stack trace: ${snapshot.stackTrace}'),
                    // ),
                  ];
                } else {
                  // กรณีอื่นๆ
                  // ตรวจสอบค่าสถานะการเชื่อมต่อ แล้วทำคำสั่งตามเงื่อนไขนั้นๆ
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: // กรณีสถานะเป็น none
                      // สร้าง widget สำหรับกรณีนี้ไว้ในตัวแปร children
                      children = const <Widget>[
                        Icon(Icons.info, color: Colors.blue, size: 60),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Select a lot'),
                        ),
                      ];
                      break;
                    case ConnectionState.waiting: // กรณีสถานะเป็น waiting
                      // สร้าง widget สำหรับกรณีนี้ไว้ในตัวแปร children
                      children = const <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting bids...'),
                        ),
                      ];
                      break;
                    case ConnectionState.active: // กรณีสถานะเป็น active
                      // สร้าง widget สำหรับกรณีนี้ไว้ในตัวแปร children
                      children = <Widget>[
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('\$${snapshot.data}'),
                        ),
                      ];
                      break;
                    case ConnectionState.done: // กรณีสถานะเป็น done
                      // สร้าง widget สำหรับกรณีนี้ไว้ในตัวแปร children
                      children = <Widget>[
                        const Icon(Icons.info, color: Colors.blue, size: 60),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('\$${snapshot.data} (closed)'),
                        ),
                      ];
                      break;
                  }
                }

                // คืนค่าเป็นรูปแบบ widget ที่กำหนดจากตัวแปร children
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                );
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

  Stream<int> _bidStream() async* {
    // จำลองการส่งข้อมูล stream
    await Future<void>.delayed(const Duration(seconds: 3));
    yield 1;
    await Future<void>.delayed(const Duration(seconds: 3));
    yield 2;
    // throw Exception('Intentional exception');
    await Future<void>.delayed(const Duration(seconds: 3));
    yield 3;
  }
}
