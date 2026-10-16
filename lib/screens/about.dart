import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class About extends StatefulWidget {
  static const routeName = '/about';

  const About({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AboutState();
  }
}

class _AboutState extends State<About> {
  final logger = Logger();

  int a = 10;
  @override
  Widget build(BuildContext context) {
    logger.i(MediaQuery.of(context).size); // สำหรับทดสอบ ดูความกว้าง สูง หน้าจอ

    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0), // ช่องว่างระหว่างขอบ
          // child: GridView.extent(
          //   mainAxisSpacing: 10.0,
          //   crossAxisSpacing: 5.0,

          //   // crossAxisCount: 2,
          //   // crossAxisCount:
          //   //     MediaQuery.of(context).orientation == Orientation.portrait
          //   //     ? 2
          //   //     : 3,
          //   // maxCrossAxisExtent: 100,
          //   maxCrossAxisExtent:
          //       (MediaQuery.of(context).size.width / 3), // แบ่งเป็น 3 คอลัมน์
          //   childAspectRatio: 0.67,

          //   children: List.generate(10, (index) {
          //     a += 10;
          //     return Container(
          //       color: Colors.blue.withAlpha(100),
          //       child: Column(
          //         children: [
          //           AspectRatio(
          //             aspectRatio: 1.0,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color: Colors.blue.withAlpha(100),
          //                 border: Border.all(color: Colors.blue, width: 1.0),
          //               ),
          //               child: Text('Picture ${index}'),
          //             ),
          //           ),
          //           Expanded(
          //             child: AspectRatio(
          //               aspectRatio: 2.0,
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   color: Colors.yellow.withAlpha(200),
          //                   border: Border.all(
          //                     color: Colors.yellow,
          //                     width: 1.0,
          //                   ),
          //                 ),
          //                 child: Text('Item ${index}'),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   }),
          // ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // แสดง 3 คอลัมน์
            ),
            itemCount: 300,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withAlpha(100),
                        border: Border.all(color: Colors.blue, width: 1.0),
                      ),
                      child: Text('Picture ${index}'),
                    ),
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 2.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow.withAlpha(200),
                          border: Border.all(color: Colors.yellow, width: 1.0),
                        ),
                        child: Text('Item ${index}'),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
