import 'package:ezak/model/decoders/hours_decoder.dart';
import 'package:time/time.dart';

Duration hourTest(int code){
  final Duration lessonTime = 45.minutes,
      startTime = 7.25.hours,
      breakLength = 10.minutes,
      breakLengthSum = breakLength * (code ~/ 2) - (code<2? 0.seconds : breakLength);

  return startTime + lessonTime * (code-1) + breakLengthSum;
}

void main() async{
  // print(hourTest(12));
  print(HoursDecoder.decodeStartHour(2));
  // var start = 7.25.hours;
  // print('${start.inHours}h ${(start  - Duration(hours: start.inHours)).inMinutes}min. ${(start - Duration(hours: start.inHours, minutes: (start  - Duration(hours: start.inHours)).inMinutes)).inSeconds} s');
}