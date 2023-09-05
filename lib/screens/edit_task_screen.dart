import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/utility/utility.dart';
import 'package:note_app/widgets/task_type_widget.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});

  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;

  final box = Hive.box<Task>('taskBox');

  DateTime? _time;

  int _selectedTaskTypeItem = 0;

  @override
  void initState() {
    super.initState();

    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);

    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });

    var _taskTypeIndex = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });

    _selectedTaskTypeItem = _taskTypeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ویرایش کردن تسک',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'SM',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff263238),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xff263238),
      body: _getMainBody(context),
    );
  }

  Widget _getMainBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: _getEditTaskView(context),
      ),
    );
  }

  Widget _getEditTaskView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          _getTaskTitleTextField(),
          SizedBox(height: 30),
          _getTaskDescriptionsTextFeild(),
          SizedBox(height: 30),
          _getCustomHourPicker(),
          SizedBox(height: 30),
          _getTypeItemList(),
          SizedBox(height: 30),
          _getEditTaskButton(context),
          SizedBox(height: 30),
        ],
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

  Widget _getTaskTitleTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44),
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

  ElevatedButton _getEditTaskButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff18DAA3),
        minimumSize: Size(200, 40),
      ),
      onPressed: () {
        String taskTitle = controllerTaskTitle!.text;
        String taskSubTitle = controllerTaskSubTitle!.text;

        editTask(
          taskTitle,
          taskSubTitle,
        );
        Navigator.of(context).pop();
      },
      child: Text(
        'ویرایش تسک',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _getTaskDescriptionsTextFeild() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44),
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

  editTask(String taskTitle, String taskSubtitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubtitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeItem];

    widget.task.save();
  }
}
