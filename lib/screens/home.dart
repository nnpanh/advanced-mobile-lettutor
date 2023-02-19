import 'package:flutter/material.dart';

import '../config/router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.counter});

  final int counter;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _counter;

  @override
  void initState() {
    _counter = widget.counter;
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    Navigator.pushNamed(context, MyRouter.courses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
