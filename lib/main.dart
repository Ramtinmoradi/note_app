import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/data/task_enum.dart';
import 'package:note_app/data/task_type.dart';
import 'package:note_app/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _getThemeData(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }

  ThemeData _getThemeData() {
    return ThemeData(
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'SM',
          fontSize: 16,
          color: Color(0xff263238),
        ),
      ),
    );
  }
}
