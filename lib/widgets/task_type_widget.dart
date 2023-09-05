import 'package:flutter/material.dart';
import 'package:note_app/data/task_type.dart';
import 'package:note_app/utility/utility.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedItemList,
  });

  TaskType taskType;
  int index;
  int selectedItemList;
  @override
  Widget build(BuildContext context) {
    return _getTaskTypeItemList();
  }

  Widget _getTaskTypeItemList() {
    return Container(
      decoration: BoxDecoration(
        color: (selectedItemList == index)
            ? Color(0xff00838F)
            : Colors.transparent,
        border: Border.all(
          color: (selectedItemList == index)
              ? Color(0xffE2F1F6)
              : Colors.transparent,
          width: (selectedItemList == index) ? 3 : 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      width: 150.0,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              color: Color(0xffE2F1F6),
              fontFamily: 'SM',
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
