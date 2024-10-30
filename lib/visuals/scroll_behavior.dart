import 'dart:ui';

import 'package:flutter/widgets.dart';

class PansScrollBehavior extends ScrollBehavior{
  @override
  Set<PointerDeviceKind> get dragDevices => {...PointerDeviceKind.values};
}