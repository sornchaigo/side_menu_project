import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  static const routeName = '/contact';

  const Contact({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContactState();
  }
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Us')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Contact Screen')],
        ),
      ),
    );
  }
}
