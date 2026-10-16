import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/counter_model.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';

  const Profile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Text('Profile Screen'),
            Text('You have pushed the button this many times:'),
            Count(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        key: const Key('increment_Button'),
        onPressed: () => context.read<CounterModel>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
