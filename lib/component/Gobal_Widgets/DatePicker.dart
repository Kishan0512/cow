import 'package:flutter/material.dart';

import 'DatePickers.dart';

class Date_Picker extends StatefulWidget {
  void Function(DateTime selectedDate) onDateChange;
  void Function() onPressed;
  Color selectionColor;
  Color selectedTextColor;
  Color buttencolor;
  int? daysCount;

  Date_Picker(
      {required this.onDateChange,
      required this.selectionColor,
      required this.onPressed,
      required this.selectedTextColor,
      required this.buttencolor,
      this.daysCount});

  @override
  State<Date_Picker> createState() => _Date_PickerState();
}

class _Date_PickerState extends State<Date_Picker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: widget.buttencolor,
          width: MediaQuery.of(context).size.width / 7.3,
          height: 100,
          child: IconButton(
              splashRadius: 18,
              onPressed: widget.onPressed,
              icon: Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
              )),
        ),
        Container(
          color: widget.buttencolor,
          // width: MediaQuery.of(context).size.width - 100,
          width: MediaQuery.of(context).size.width / 1.24,
          height: 100,
          child: DatePicker(
            width: MediaQuery.of(context).size.width / 7.3,
            daysCount: widget.daysCount ?? 5,
            DateTime.now()
                .subtract(Duration(days: ((widget.daysCount ?? 5) - 1))),
            initialSelectedDate: DateTime.now(),
            selectionColor: widget.selectionColor,
            selectedTextColor: widget.selectedTextColor,
            onDateChange: widget.onDateChange,
            dateTextStyle: TextStyle(fontSize: 20),
            dayTextStyle: TextStyle(fontSize: 10),
            monthTextStyle: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
