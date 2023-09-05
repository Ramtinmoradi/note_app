import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/data/task_type.dart';
import 'package:note_app/utility/utility.dart';
import 'package:note_app/widgets/task_type_widget.dart';
import 'package:time_pickerr/time_pickerr.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerTaskSubTitle = TextEditingController();

  final box = Hive.box<Task>('taskBox');

  DateTime? _time;

  int _selectedTaskTypeItem = 0;

  @override
  void initState() {
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اضافه کردن تسک',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'SM',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff263238),
        elevation: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff263238),
      body: _getMainBody(context),
    );
  }

  Widget _getMainBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: _getAddTaskView(context),
      ),
    );
  }

  Widget _getAddTaskView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          _getTaskTitleTextField(),
          SizedBox(height: 30),
          _getTaskDescriptionTextField(),
          SizedBox(height: 30),
          _getCustomHourPicker(),
          SizedBox(height: 30),
          _getTypeItemList(),
          SizedBox(height: 30),
          _getAddTaskButton(context),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _getTaskDescriptionTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: controllerTaskSubTitle,
          maxLines: 3,
          focusNode: negahban2,
          style: TextStyle(
            color: Color(0xffE2F1F6),
            fontFamily: 'SM',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            labelText: 'توضیحات تسک',
            labelStyle: TextStyle(
              fontFamily: 'SM',
              fontSize: 20,
              color: negahban2.hasFocus ? Color(0xff18DAA3) : Color(0xffE2F1F6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: Color(0xffE2F1F6),
                width: 3.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                width: 3,
                color: Color(0xff18DAA3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTaskTitleTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: controllerTaskTitle,
          focusNode: negahban1,
          style: TextStyle(
            color: Color(0xffE2F1F6),
            fontFamily: 'SM',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            labelText: 'عنوان تسک',
            labelStyle: TextStyle(
              fontFamily: 'SM',
              fontSize: 20,
              color: negahban1.hasFocus ? Color(0xff18DAA3) : Color(0xffE2F1F6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: Color(0xffE2F1F6),
                width: 3.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                width: 3,
                color: Color(0xff18DAA3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTypeItemList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 200.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: getTaskTypeList().length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTaskTypeItem = index;
                });
              },
              child: TaskTypeItemList(
                taskType: getTaskTypeList()[index],
                index: index,
                selectedItemList: _selectedTaskTypeItem,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getAddTaskButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff18DAA3),
        minimumSize: Size(200, 40),
      ),
      onPressed: () {
        String taskTitle = controllerTaskTitle.text;
        String taskSubTitle = controllerTaskSubTitle.text;
        addTask(taskTitle, taskSubTitle);
        Navigator.of(context).pop();
      },
      child: Text(
        'اضافه کردن تسک',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _getCustomHourPicker() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomHourPicker(
        title: 'مشخص کردن زمان تسک',
        negativeButtonText: 'حذف کردن',
        positiveButtonText: 'تایید زمان',
        elevation: 2,
        titleStyle: TextStyle(
          color: Color(0xff18DAA3),
          fontFamily: 'SM',
          fontSize: 18,
        ),
        positiveButtonStyle: TextStyle(
          color: Color(0xff263238),
          fontFamily: 'SM',
          fontSize: 14,
        ),
        negativeButtonStyle: TextStyle(
          color: Color(0xffD50000),
          fontFamily: 'SM',
          fontSize: 14,
        ),
        onPositivePressed: (context, time) {
          _time = time;
        },
        onNegativePressed: (context) {},
      ),
    );
  }

  addTask(String taskTitle, String taskSubtitle) {
    var task = Task(
      title: taskTitle,
      subTitle: taskSubtitle,
      time: _time!,
      taskType: getTaskTypeList()[_selectedTaskTypeItem],
    );
    box.add(task);
  }
}
