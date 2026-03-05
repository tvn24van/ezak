import 'package:flutter/foundation.dart';

void debugOnlyPrint(String message){
  if(kDebugMode){
    debugPrint(message);
  }
}