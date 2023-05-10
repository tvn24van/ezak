import 'dart:ui';

import 'package:ezak/model/group.dart';
import 'package:ezak/utils/constants.dart';
import 'package:flutter/foundation.dart';

typedef GroupsMap = Map<Group, Set<int>>;

@immutable
class Settings{

  /// true if dark theme is selected
  final bool darkTheme;

  /// locale in which app will be displayed
  final Locale locale;

  /// true if user selected teacher's mode
  final bool isTeacher;

  /// identifies which semester and specialization
  /// user wants to display
  final int specializationKey;

  /// groups selected to display
  final GroupsMap groups;

  const Settings({
    bool? darkTheme,
    Locale? locale,
    bool? isTeacher,
    int? specializationKey,
    GroupsMap? groups,
  }):
  locale = locale ?? Constants.defaultLocale,
  darkTheme = darkTheme ?? false,
  isTeacher = isTeacher ?? false,
  specializationKey = specializationKey ?? defaultSpecializationKey, // 0 when no groups were selected
  groups = groups ?? Settings.defaultGroups;

  static const int defaultSpecializationKey = 0;

  static const GroupsMap defaultGroups = {
    Group.lecture: <int>{},
    Group.laboratories: <int>{},
    Group.exercises: <int>{},
    Group.project: <int>{},
    Group.seminar: <int>{},
  };

  // static const GroupsMap defaultGroups = GroupsMap.fromEntries( //sadly, any of these work
  //   // for(var group in Group.values) group: <int>{1}
  //   for(var group in Group.values) MapEntry(group, <int>{1})
  //   // Group.values.map((group) => MapEntry(group, <int>{1}))
  // );

  Settings copyWith({
    bool? darkTheme,
    Locale? locale,
    bool? isTeacher,
    int? specializationKey,
    GroupsMap? groups,
  })=> Settings(
    darkTheme: darkTheme ?? this.darkTheme,
    locale: locale ?? this.locale,
    isTeacher: isTeacher ?? this.isTeacher,
    specializationKey: specializationKey ?? this.specializationKey,
    groups: groups ?? this.groups,
  );

}