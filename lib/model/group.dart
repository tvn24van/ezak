import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// [Group] represents type of course which could be a
/// [lecture], [exercises], [laboratories], [project] or [seminar]
/// WARNING !!! DO NOT CHANGE ORDER OF ENUMS TO PRESERVE ITS INDEXES NEEDED FOR DB
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Group{

  @JsonValue('W')
  lecture(Colors.green, 'W'),

  @JsonValue('C')
  exercises(Colors.yellowAccent, 'C'),

  @JsonValue('L')
  laboratories(Colors.blue, 'L'),

  @JsonValue('P')
  project(Colors.redAccent, 'P'),

  @JsonValue('S')
  seminar(Colors.orangeAccent, 'S');

  /// Used for distinguishing Groups by colours
  final Color color;
  /// Shortcut for each Group
  final String symbol;

  const Group(this.color, this.symbol);

  @override
  String toString(){
    return symbol;
  }

  static Group ofSymbol(String symbol){
    return Group.values.singleWhere((element) => element.symbol == symbol);
  }

}