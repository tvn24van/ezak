import 'package:ezak/model/group.dart';
import 'package:ezak/model/settings.dart';
import 'package:ezak/providers/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class _SettingsKeys{
  static final darkTheme = "darkTheme";
  static final autoUpdates = "autoUpdates";
  static final locale = "locale";
  static final isLecturer = "isTeacher"; // backwards comp.
  static final specializationKey = "specializationKey";
  static final lecturerKey = "lecturerKey";
  // static final groups = "groups"; // this is auto-generated
}

final class SettingsProvider extends Notifier<Settings>{

  static final instance = NotifierProvider<SettingsProvider, Settings>(()=>
    SettingsProvider()
  );

  /// provides key of specialization or lecturer according to selected setting
  static final key = Provider((ref){
    final isLecturer = ref.watch(instance.select((value) => value.isLecturer));
    return ref.watch(instance.select((value) => isLecturer? value.lecturerKey : value.specializationKey));
  });

  @override
  Settings build() {
    final sp = ref.read(sharedPreferences);
    final groups = GroupsMap.fromEntries(
      Group.values.map((group) =>
        MapEntry(
          group,
          sp.getStringList(group.name)?.map(int.parse).toSet() ?? <int>{}
        )
      )
    );
    final noGroups = groups.areGroupsEmpty();

    return Settings(
      darkTheme: sp.getBool(_SettingsKeys.darkTheme),
      autoUpdates: sp.getBool(_SettingsKeys.autoUpdates),
      locale: sp.getString(_SettingsKeys.locale)!=null? Locale(sp.getString(_SettingsKeys.locale)!) : null,
      isLecturer: sp.getBool(_SettingsKeys.isLecturer),
      specializationKey: sp.getInt(_SettingsKeys.specializationKey),
      lecturerKey: sp.getInt(_SettingsKeys.lecturerKey),
      groups: noGroups? null : groups,
    );
  }

  void changeLocale(Locale locale){
    state = state.copyWith(
      locale: locale
    );
    ref.read(sharedPreferences).setString(_SettingsKeys.locale, locale.languageCode);
  }

  void toggleTheme(){
    state = state.copyWith(
      darkTheme: !state.darkTheme
    );
    ref.read(sharedPreferences).setBool(_SettingsKeys.darkTheme, state.darkTheme);
  }

  void toggleAutoUpdates(){
    state = state.copyWith(
        autoUpdates: !state.autoUpdates
    );
    ref.read(sharedPreferences).setBool(_SettingsKeys.autoUpdates, state.autoUpdates);
  }

  void toggleTeacherMode(){
    state = state.copyWith(
      isLecturer: !state.isLecturer
    );
    ref.read(sharedPreferences).setBool(_SettingsKeys.isLecturer, state.isLecturer);
  }

  void _saveGroupNumbers(Group group){
    final sp = ref.read(sharedPreferences);
    sp.setStringList(
      group.name, state.groups[group]?.map((number)=>'$number').toList() ?? []
    );
  }

  void setGroupNumbers(Group group, Set<int> numbers){
    final newGroups = GroupsMap.from(state.groups)..update(group, (value) => numbers);
    // // ref.read(CoursesProvider.instance).value?.filter(newGroups);
    state = state.copyWith(
      groups: newGroups
    );
    _saveGroupNumbers(group);

    // after group changes some days may completely disappear however index of
    // current day stays the same and this may cause problems so here are some
    // checks todo remove this!
    // final schedule = ref.read(CoursesProvider.instance).value;
    // if(schedule!=null){
    //   if(!schedule.containsDate(ref.read(SchedulePage.currentDate))){
    //     final accurateDate = schedule.getAccurateDate();
    //     ref.read(SchedulePage.currentDate.notifier)
    //         .update((state) => accurateDate);
    //     ref.read(SchedulePage.pageViewController.notifier).update((state) =>
    //         PageController(initialPage: schedule.getIndexOfDate(accurateDate))
    //     );
    //   }
    // }
  }


  void toggleGroupNumber(Group group, int number){
    final groupNumbers = state.groups[group]!.toSet(); //creating new Set

    if(groupNumbers.contains(number)) {
      groupNumbers.remove(number);
    }else{
      groupNumbers.add(number);
    }

    final newGroups = GroupsMap.fromEntries(state.groups.entries)
      ..update(group, (value) => groupNumbers);

    // ref.read(CoursesProvider.instance).value?.filter(newGroups);

    state = state.copyWith(
      groups: newGroups
    );

    _saveGroupNumbers(group);
  }

  void changeKey(int key){
    final isLecturer = ref.read(instance.select((value) => value.isLecturer));
    state = state.copyWith(
      lecturerKey: isLecturer? key : null,
      specializationKey: !isLecturer? key : null
    );
    ref.read(sharedPreferences).setInt(isLecturer? _SettingsKeys.lecturerKey : _SettingsKeys.specializationKey, key);
  }

}