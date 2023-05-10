
// enum Hour{
//
//   h715(1),
//   h800(2),
//   h845(3),
//   h930;
//
//   final int code;
//   const Hour(this.code);
// }

import 'package:ezak/model/decoders/hours_decoder.dart';
import 'package:time/time.dart';

void main(){

  // print(HoursDecoder.decodeStartHour(1));

  // print(HoursDecoder.decodeStartHour(1 + 1) - (1%2==0? 0.minutes : 10.minutes));

  print(HoursDecoder.decodeEndHour(11, 2));
  print(HoursDecoder.decodeEndHour(15, 1));

  print(HoursDecoder.decodeEndHour(14,3));

}