import 'package:flutter/material.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/screens/edit_task_screen.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});

  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    super.initState();

    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return _getTaskItem();
  }

  Widget _getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        height: 132.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: _getMainContent(),
      ),
    );
  }

  Widget _getMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _getTaskView(),
          SizedBox(width: 20),
          Image.asset(widget.task.taskType.image),
        ],
      ),
    );
  }

  Widget _getTaskView() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _getCheckboxAndTitle(),
          _getTaskSubTitle(),
          Spacer(),
          _getTimeAndEditBadgs(),
        ],
      ),
    );
  }

  Widget _getTaskSubTitle() {
    return Text(
      widget.task.subTitle,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getCheckboxAndTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getCheckBox(),
        _getTaskTitle(),
      ],
    );
  }

  Text _getTaskTitle() {
    return Text(
      widget.task.title,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _getCheckBox() {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        value: isBoxChecked,
        checkColor: Color(0xffFFFFFF),
        activeColor: Color(0xff18DAA3),
        onChanged: (isChecked) {},
      ),
    );
  }

  Widget _getTimeAndEditBadgs() {
    return Row(
      children: [
        _getTimeandEditBadgsContainer(
            badgsColor: 0xff18DAA3,
            badgsText:
                '${widget.task.time.hour}:${_getMinuteUnderTen(widget.task.time)}',
            textColor: 0xffFFFFFF,
            textFont: '',
            badgsImage: 'icon_time'),
        SizedBox(width: 15),
        _getTimeandEditBadgsContainer(
            badgsColor: 0xffE2F1F6,
            badgsText: 'ویرایش',
            textColor: 0xff18DAA3,
            textFont: 'SM',
            badgsImage: 'icon_edit'),
      ],
    );
  }

  Widget _getTimeandEditBadgsContainer(
      {required int badgsColor,
      required String badgsText,
      required int textColor,
      required String textFont,
      required String badgsImage}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditTaskScreen(
              task: widget.task,
            ),
          ),
        );
      },
      child: Container(
        width: 100.0,
        height: 28.0,
        decoration: BoxDecoration(
          color: Color(badgsColor),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                badgsText,
                style: TextStyle(
                  color: Color(textColor),
                  fontFamily: textFont,
                ),
              ),
              SizedBox(width: 10),
              Image.asset('images/$badgsImage.png'),
            ],
          ),
        ),
      ),
    );
  }

  String _getMinuteUnderTen(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }
}
