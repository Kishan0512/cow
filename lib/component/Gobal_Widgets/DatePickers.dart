import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final DateTime startDate;
  final double width;
  final double height;
  final DatePickerController? controller;
  final Color selectedTextColor;
  final Color selectionColor;
  final Color deactivatedColor;
  final TextStyle monthTextStyle;
  final TextStyle dayTextStyle;
  final TextStyle dateTextStyle;
  final DateTime? /*?*/ initialSelectedDate;
  final List<DateTime>? inactiveDates;
  final List<DateTime>? activeDates;
  final DateChangeListener? onDateChange;
  final int daysCount;
  final String locale;
  DatePicker(
    this.startDate, {
    Key? key,
    this.width = 60,
    this.height = 80,
    this.controller,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _currentDate;
  ScrollController _controller = ScrollController();
  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;
  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;
  @override
  void initState() {
    initializeDateFormatting(widget.locale, null);

    _currentDate = widget.initialSelectedDate;

    if (widget.controller != null) {
      widget.controller!.setDatePickerState(this);
    }
    this.selectedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    this.selectedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    this.selectedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.selectedTextColor);
    this.deactivatedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    this.deactivatedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.deactivatedColor);
    this.deactivatedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.deactivatedColor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.daysCount,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, index) {
          DateTime date;
          DateTime _date = widget.startDate.add(Duration(days: index));
          date = new DateTime(_date.year, _date.month, _date.day);
          bool isDeactivated = false;
          if (widget.inactiveDates != null) {
            for (DateTime inactiveDate in widget.inactiveDates!) {
              if (_compareDate(date, inactiveDate)) {
                isDeactivated = true;
                break;
              }
            }
          }
          if (widget.activeDates != null) {
            isDeactivated = true;
            for (DateTime activateDate in widget.activeDates!) {
              if (_compareDate(date, activateDate)) {
                isDeactivated = false;
                break;
              }
            }
          }
          bool isSelected =
              _currentDate != null ? _compareDate(date, _currentDate!) : false;
          return DateWidget(
            date: date,
            monthTextStyle: isDeactivated
                ? deactivatedMonthStyle
                : isSelected
                    ? selectedMonthStyle
                    : widget.monthTextStyle,
            dateTextStyle: isDeactivated
                ? deactivatedDateStyle
                : isSelected
                    ? selectedDateStyle
                    : widget.dateTextStyle,
            dayTextStyle: isDeactivated
                ? deactivatedDayStyle
                : isSelected
                    ? selectedDayStyle
                    : widget.dayTextStyle,
            width: widget.width,
            locale: widget.locale,
            selectionColor:
                isSelected ? widget.selectionColor : Colors.transparent,
            onDateSelected: (selectedDate) {
              if (isDeactivated) return;
              if (widget.onDateChange != null) {
                widget.onDateChange!(selectedDate);
              }
              setState(() {
                _currentDate = selectedDate;
              });
            },
          );
        },
      ),
    );
  }

  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  _DatePickerState? _datePickerState;
  void setDatePickerState(_DatePickerState state) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');
    _datePickerState!._controller
        .jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');
    _datePickerState!._controller.animateTo(
        _calculateDateOffset(_datePickerState!._currentDate!),
        duration: duration,
        curve: curve);
  }

  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  void setDateAndAnimate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
    if (date.compareTo(_datePickerState!.widget.startDate) >= 0 &&
        date.compareTo(_datePickerState!.widget.startDate
                .add(Duration(days: _datePickerState!.widget.daysCount))) <=
            0) {
      _datePickerState!._currentDate = date;
    }
  }

  double _calculateDateOffset(DateTime date) {
    final startDate = new DateTime(
        _datePickerState!.widget.startDate.year,
        _datePickerState!.widget.startDate.month,
        _datePickerState!.widget.startDate.day);

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;
  DateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  new DateFormat("MMM", locale)
                      .format(date)
                      .toUpperCase(), // Month
                  style: monthTextStyle),
              Text(date.day.toString(), // Date
                  style: dateTextStyle),
              Text(
                  new DateFormat("E", locale)
                      .format(date)
                      .toUpperCase(), // WeekDay
                  style: dayTextStyle)
            ],
          ),
        ),
      ),
      onTap: () {
        if (onDateSelected != null) {
          onDateSelected!(this.date);
        }
      },
    );
  }
}

/// Used by [DatePickerTimeline] for tap detection.
typedef DateSelectionCallback = void Function(DateTime selectedDate);

/// Used by [DatePickerTimeline] for tap detection.
typedef DateChangeListener = void Function(DateTime selectedDate);

class AppColors {
  AppColors._();
  static const Color defaultDateColor = Colors.black;
  static const Color defaultDayColor = Colors.black;
  static const Color defaultMonthColor = Colors.black;
  static const Color defaultSelectionColor = Color(0x30000000);
  static const Color defaultDeactivatedColor = Color(0xFF666666);
}

class Dimen {
  Dimen._();
  static const double dateTextSize = 24;
  static const double dayTextSize = 11;
  static const double monthTextSize = 11;
}

const TextStyle defaultMonthTextStyle = TextStyle(
  color: AppColors.defaultMonthColor,
  fontSize: Dimen.monthTextSize,
  fontWeight: FontWeight.w500,
);
const TextStyle defaultDateTextStyle = TextStyle(
  color: AppColors.defaultDateColor,
  fontSize: Dimen.dateTextSize,
  fontWeight: FontWeight.w500,
);
const TextStyle defaultDayTextStyle = TextStyle(
  color: AppColors.defaultDayColor,
  fontSize: Dimen.dayTextSize,
  fontWeight: FontWeight.w500,
);
