import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/counter_model.dart';

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
    CounterModel counter = context.read<CounterModel>();

    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('About Us Screen'),

            Consumer<CounterModel>(
              builder: (context, counter, child) {
                return Column(
                  children: [
                    Text(
                      '${counter.count}',
                      key: const Key('counterState'),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    ?child,
                  ],
                );
              },
              child: ElevatedButton(
                onPressed: () => counter.reset(),
                child: Text('Reset Counter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
