import 'package:ezak/model/decoders/time_decoder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  test("expect start hour of 4 to represent 9:40", (){
    expect(const TimeOfDay(hour: 9, minute: 40), TimeDecoder.decodeStartTime(4));
  });

  test("expect end hour of 4 with duration of 2 to represent 11:10", (){
    expect(const TimeOfDay(hour: 11, minute: 10), TimeDecoder.decodeEndTime(4, 2));
  });

  //

  test("expect start hour of 14 to represent 18:00", (){
    expect(const TimeOfDay(hour: 18, minute: 0), TimeDecoder.decodeStartTime(14));
  });

  test("expect end hour of 14 with duration of 1 to represent 18:45", (){
    expect(const TimeOfDay(hour: 18, minute: 45), TimeDecoder.decodeEndTime(14, 1));
  });

}