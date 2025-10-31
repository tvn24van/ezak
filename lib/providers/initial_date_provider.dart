import 'package:ezak/providers/dates_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialDateProvider = FutureProvider((ref) async{
  final allDates = await ref.watch(datesProvider.future);
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
    return allDates.firstWhere((element) => element.isAfter(currentDate));
  }
});