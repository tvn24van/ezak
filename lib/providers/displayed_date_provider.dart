import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//todo add checking if was current day, but should be now changed
  final displayedDate = StateProvider<DateTime>((ref)=> DateTime.now());
  
  DateTime getInitialDate(List<DateTime> dates) {
    final currentDate = DateUtils.dateOnly(DateTime.now());
    final firstDate = dates.first;
    final lastDate = dates.last;

    if(dates.contains(currentDate)){
      return currentDate;
    }else if(currentDate.isBefore(firstDate)){
      return firstDate;
    }else if(currentDate.isAfter(lastDate)) {
      return lastDate;
    }else{
      return dates.firstWhere((element) =>
          element.isAfter(currentDate)
      );
    }
  }