import 'package:flutter/material.dart';

import '../const/themes.dart';

final ThemeManager _themeManager = ThemeManager();

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key, required this.counter});

  final int counter;

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {

  @override
  void initState() {
    _counter = widget.counter;
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener(){
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  late int _counter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
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
      floatingActionButton: Switch(
        value: _themeManager.themeMode == ThemeMode.dark,
        onChanged: (newValue) {
          _themeManager.toggleTheme(newValue);
          },
      ),
    );
  }
}
