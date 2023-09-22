import 'package:ezak/model/course.dart';
import 'package:ezak/model/group.dart';
import 'package:ezak/model/settings.dart';
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
  CoursesList getCoursesForDateAndGroup(DateTime date, GroupsMap groups);
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

  final DatesMap _filteredDates = {};

  void removeFilter(){
    _filteredDates.clear();
    _filteredDates.addAll(_dates);
  }

  void filter(GroupsMap groupsMap){
    removeFilter();
    if(!groupsMap.areGroupsEmpty()) {
      _filteredDates.removeWhere((date, coursesIDs) =>
        _courses
          .where((course) => coursesIDs.contains(course.id))
          .where((course) => groupsMap[course.group]!.contains(course.groupNumber))
          .isEmpty
      );
    }
  }

  @override
  CoursesList getCoursesForDate(DateTime date){
    // final ids = _filteredDates.entries.firstWhere((element) => element.key == date).value;
    final ids = _filteredDates.entries.where((element) => element.key == date);
    if(ids.isEmpty) {
      return [];
    }
    return [ for(final id in ids.first.value) _courses.singleWhere((element) => element.id == id) ];
  }

  @override
  CoursesList getCoursesForDateAndGroup(DateTime date, GroupsMap groups){
    return getCoursesForDate(date)
      ..removeWhere((element) => !groups[element.group]!.contains(element.groupNumber));
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
      return _filteredDates.keys.firstWhere((element) =>
        element.isAfter(currentDate)
      );
    }
  }

  @override
  int getIndexOfDate(DateTime date){
    return _filteredDates.keys.toList().indexOf(date);
  }

  @override
  DateTime getDateOfIndex(int index){
    return _filteredDates.keys.elementAt(index);
  }

  bool containsDate(DateTime date){
    return _filteredDates.containsKey(date);
  }

  @override
  DateTime getFirstDayDate(){
    return _filteredDates.keys.first;
  }

  @override
  DateTime getLastDayDate(){
    return _filteredDates.keys.last;
  }

  @override
  int getDaysAmount(){
    return _filteredDates.length;
  }

  int getMaxGroupNumber(Group group){
    final coursesOfGroup = _courses.where((course) => course.group==group);
    if(coursesOfGroup.isEmpty) {
      return 0;
    }
    return coursesOfGroup.reduce(
      (curr, next) =>
        curr.groupNumber > next.groupNumber?
          curr:
          next
    ).groupNumber;
  }

}