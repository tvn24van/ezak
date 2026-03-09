import 'dart:ui';

import 'package:ezak/model/group.dart';
import 'package:ezak/utils/constants.dart';
import 'package:flutter/foundation.dart';

typedef GroupsMap = Map<Group, Set<int>>;

extension GroupsMapExtension on GroupsMap{
  bool areGroupsEmpty(){
    return values.every((element) => element.isEmpty);
  }
}

@immutable
class Settings{

  /// true if dark theme is selected
  final bool darkTheme;

  final bool highContrast;

  final bool leftHandMode;

  final bool autoUpdates;

  /// locale in which app will be displayed
  final Locale locale;

  /// true if user selected lecturer's mode
  final bool isLecturer;

  /// identifies which semester and specialization
  /// user wants to display
  final int specializationKey;

  /// similar to [specializationKey]
  final int lecturerKey;

  /// groups selected to display
  final GroupsMap groups;

  const Settings({
    bool? darkTheme,
    bool? highContrast,
    bool? leftHandMode,
    bool? autoUpdates,
    Locale? locale,
    bool? isLecturer,
    int? specializationKey,
    int? lecturerKey,
    GroupsMap? groups,
  }):
  locale = locale ?? Constants.defaultLocale,
  darkTheme = darkTheme ?? false,
  highContrast = highContrast ?? false,
  leftHandMode = leftHandMode ?? false,
  autoUpdates = autoUpdates ?? true,
  isLecturer = isLecturer ?? false,
  specializationKey = specializationKey ?? defaultKey,
  lecturerKey = lecturerKey ?? defaultKey,
  groups = groups ?? Settings.defaultGroups;

  static const int defaultKey = 0;

  static const GroupsMap defaultGroups = {
    Group.lecture: <int>{},
    Group.laboratories: <int>{},
    Group.exercises: <int>{},
    Group.project: <int>{},
    Group.seminar: <int>{},
  };

  Settings copyWith({
    bool? darkTheme,
    bool? highContrast,
    bool? leftHandMode,
    bool? autoUpdates,
    Locale? locale,
    bool? isLecturer,
    int? specializationKey,
    int? lecturerKey,
    GroupsMap? groups,
  })=> Settings(
    darkTheme: darkTheme ?? this.darkTheme,
    highContrast: highContrast ?? this.highContrast,
    leftHandMode: leftHandMode ?? this.leftHandMode,
    autoUpdates: autoUpdates ?? this.autoUpdates,
    locale: locale ?? this.locale,
    isLecturer: isLecturer ?? this.isLecturer,
    specializationKey: specializationKey ?? this.specializationKey,
    lecturerKey: lecturerKey ?? this.lecturerKey,
    groups: groups ?? this.groups,
  );

}