import 'package:ezak/model/group.dart';
import 'package:ezak/model/settings.dart';
import 'package:ezak/providers/schedule_provider.dart';
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

  /// provides current settings
  static final instance = NotifierProvider<SettingsProvider, Settings>(()=>
    SettingsProvider()
  );

  /// indicates if user completed schedule selection
  static final completed = Provider((ref)=> ref.watch(key) != Settings.defaultKey);

  static final isLecturer = Provider((ref) {
    return ref.watch(instance.select((value) => value.isLecturer));
  });

  /// provides key of specialization or lecturer according to selected setting
  static final key = Provider((ref){
    final isLecturer = ref.watch(instance.select((value) => value.isLecturer));
    return ref.watch(instance.select((value) => isLecturer? value.lecturerKey : value.specializationKey));
  });

  /// provides groups with the difference that lecturer always get them empty
  /// to force [ScheduleProvider] to get all courses
  static final groups = Provider((ref){
    final isLecturer = ref.watch(instance.select((s) => s.isLecturer));
    return isLecturer? Settings.defaultGroups : ref.watch(instance.select((s)=> s.groups));
  });

  static final autoUpdates = Provider((ref){
    final isLecturer = ref.watch(instance.select((value) => value.isLecturer));
    return isLecturer? false : ref.watch(instance.select((value) => value.autoUpdates));
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
    state = state.copyWith(
      groups: newGroups
    );
    _saveGroupNumbers(group);
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

    state = state.copyWith(
      groups: newGroups
    );

    _saveGroupNumbers(group);
  }

  void changeKey(int key){
    final isLecturer = state.isLecturer;
    state = state.copyWith(
      lecturerKey: isLecturer? key : null,
      specializationKey: !isLecturer? key : null
    );
    ref.read(sharedPreferences).setInt(isLecturer? _SettingsKeys.lecturerKey : _SettingsKeys.specializationKey, key);
  }

  void resetKeys(){
    state = state.copyWith(
      lecturerKey: Settings.defaultKey,
      specializationKey: Settings.defaultKey
    );
    ref.read(sharedPreferences)
      ..setInt(_SettingsKeys.lecturerKey, Settings.defaultKey)
      ..setInt(_SettingsKeys.specializationKey, Settings.defaultKey);
  }

  void resetCurrentKey(){
    changeKey(Settings.defaultKey);
  }

}