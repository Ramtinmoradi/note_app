import 'package:flutter/material.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTimeScreen extends StatefulWidget {
  const EditTimeScreen({super.key});

  @override
  State<EditTimeScreen> createState() => _EditTimeScreenState();
}

class _EditTimeScreenState extends State<EditTimeScreen> {
  DateTime? _time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff263238),
      body: SafeArea(
        child: _getCustomHourPicker(),
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
}
