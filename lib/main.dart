import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/task_provider.dart';
import './page/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final them = ThemeData();
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'ToDo app',
        theme: ThemeData(
          primaryColor: Colors.blue[800],
          colorScheme: them.colorScheme.copyWith(secondary: Colors.blue),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                headline2: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                headline3: const TextStyle(
                  fontSize: 15,
                  color: Colors.white38,
                ),
              ),
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
