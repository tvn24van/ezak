import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

//todo add checking if was current day, but should be now changed
//todo move from legacy way
  final displayedDate = StateProvider<DateTime>((ref)=> DateTime.now());

  DateTime getInitialDate(List<DateTime> allDates) {
    final currentDate = DateUtils.dateOnly(DateTime.now());
    final firstDate = allDates.first;
    final lastDate = allDates.last;

    if(allDates.contains(currentDate)){
      return currentDate;
    }else if(currentDate.isBefore(firstDate)){
      return firstDate;
    }else if(currentDate.isAfter(lastDate)) {
      return lastDate;
    }else{
      return allDates.firstWhere((element) =>
        element.isAfter(currentDate)
      );
    }
  }

  List<DateTime> getDatesAround(List<DateTime> allDates, {required DateTime currentDate}){
    final initialDateIndex = allDates.indexOf(currentDate);
    final indexes = [initialDateIndex-1, initialDateIndex, initialDateIndex+1].where((e) => e>=0 && e<allDates.length);
    return allDates.asMap().entries
      .where((e) => indexes.contains(e.key))
      .map((e) => e.value)
      .toList();
  }