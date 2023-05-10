import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class WidgetTransformable{
  /// * Turns model class object into Widget *
  Widget toWidget(BuildContext context);
}

abstract class ConsumerWidgetTransformable{
  /// * Turns model class object into ConsumerWidget *
  Widget toConsumerWidget(BuildContext context, WidgetRef ref);
}