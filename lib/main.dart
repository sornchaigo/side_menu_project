import 'package:flutter/material.dart';

import './screens/home.dart';
import './screens/contact.dart';
import './screens/profile.dart';
import './screens/about.dart';
import './screens/settings.dart';

void main() {
  runApp(const MyApp());
}

// ส่วนของ Stateless widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.purple),
      ),
      title: 'First Flutter App',
      // home: Home(),
      initialRoute: Home.routeName, // สามารถใช้ home แทนได้
      routes: {
        Home.routeName: (context) => Home(),
        About.routeName: (context) => About(),
        Profile.routeName: (context) => Profile(),
        Contact.routeName: (context) => Contact(),
        Settings.routeName: (context) => Settings(),
      },
    );
  }
}
