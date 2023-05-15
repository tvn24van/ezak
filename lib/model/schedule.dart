import 'package:ezak/model/course.dart';
import 'package:ezak/widgets/mixins/schedule_widget.dart';
import 'package:flutter/material.dart';

/// Type in which dates and ids of courses are stored
typedef DatesMap = Map<DateTime, List<int>>;
/// Type which is simply a shortcut for List of Courses
typedef CoursesList = List<Course>;

/// General look of Schedule
abstract class ScheduleModel{

  final DatesMap _dates;
  final CoursesList _courses;

  ScheduleModel(this._dates, this._courses);

  CoursesList getCoursesForDate(DateTime date);
  DateTime getDateOfIndex(int index);
  int getIndexOfDate(DateTime date);
  int getDaysAmount();
  DateTime getAccurateDate();
  DateTime getFirstDayDate();
  DateTime getLastDayDate();

}

/// Handles courses and its dates
@immutable
class Schedule extends ScheduleModel with ScheduleWidget{
  Schedule(super.dates, super.courses);

  @override
  CoursesList getCoursesForDate(DateTime date){
    final ids = _dates.entries.firstWhere((element) => element.key == date).value;
    return [ for(final id in ids) _courses.singleWhere((element) => element.id == id) ];
  }

  @override
  DateTime getAccurateDate(){
    final currentDate = DateUtils.dateOnly(DateTime.now());
    final firstDate = getFirstDayDate();
    final lastDate = getLastDayDate();

    if(containsDate(currentDate)){
      return currentDate;
    }else if(currentDate.isBefore(firstDate)){
      return firstDate;
    }else if(currentDate.isAfter(lastDate)) {
      return lastDate;
    }else{
      return _dates.keys.firstWhere((element) =>
        element.isAfter(currentDate)
      );
    }
  }

  @override
  int getIndexOfDate(DateTime date){
    return _dates.keys.toList().indexOf(date);
  }

  @override
  DateTime getDateOfIndex(int index){
    return _dates.keys.elementAt(index);
  }

  bool containsDate(DateTime date){
    return _dates.containsKey(date);
  }

  @override
  DateTime getFirstDayDate(){
    return _dates.keys.first;
  }

  @override
  DateTime getLastDayDate(){
    return _dates.keys.last;
  }

  @override
  int getDaysAmount(){
    return _dates.length;
  }

  int getMaxGroupNumber(){
    return _courses.reduce(
      (curr, next) =>
        curr.groupNumber > next.groupNumber?
          curr:
          next
    ).groupNumber;
  }

}