import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/screens/add_task_screen.dart';
import 'package:note_app/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');

  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff263238),
        elevation: 0.0,
        title: Text(
          'لیست تسک ها',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'SM',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xff263238),
      body: SafeArea(
        child: Center(
          child: _getValueListenableBuilder(),
        ),
      ),
      floatingActionButton: _getfloatingActionButton(context),
    );
  }

  Widget _getfloatingActionButton(BuildContext context) {
    return Visibility(
      visible: isFabVisible,
      child: FloatingActionButton(
        backgroundColor: Color(0xff18DAA3),
        child: Image.asset('images/icon_add.png'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _getValueListenableBuilder() {
    return ValueListenableBuilder(
      valueListenable: taskBox.listenable(),
      builder: (context, value, child) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            setState(() {
              if (notification.direction == ScrollDirection.forward) {
                isFabVisible = true;
              }
              if (notification.direction == ScrollDirection.reverse) {
                isFabVisible = false;
              }
            });

            return true;
          },
          child: ListView.builder(
            itemCount: taskBox.values.length,
            itemBuilder: (context, index) {
              var task = taskBox.values.toList()[index];
              return _getListItem(task);
            },
          ),
        );
      },
    );
  }

  Widget _getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      child: TaskWidget(task: task),
      onDismissed: (direction) {
        task.delete();
      },
    );
  }
}
