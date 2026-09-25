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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('About Us Screen')],
        ),
      ),
    );
  }
}
