import 'dart:ui';

import 'package:ezak/model/group.dart';
import 'package:ezak/model/settings.dart';
import 'package:ezak/providers/schedule_provider.dart';
import 'package:ezak/providers/shared_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsProvider extends Notifier<Settings>{

  static final instance = NotifierProvider<SettingsProvider, Settings>(()=>
    SettingsProvider()
  );

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
      darkTheme: sp.getBool('darkTheme'),
      locale: sp.getString('locale')!=null? Locale(sp.getString('locale')!) : null,
      isTeacher: sp.getBool('isTeacher'),
      specializationKey: sp.getInt('specialization'),
      groups: noGroups? null : groups,
    );
  }

  void changeLocale(Locale locale){
    state = state.copyWith(
      locale: locale
    );
    ref.read(sharedPreferences).setString('locale', locale.languageCode);
  }

  void toggleTheme(){
    state = state.copyWith(
      darkTheme: !state.darkTheme
    );
    ref.read(sharedPreferences).setBool('darkTheme', state.darkTheme);
  }

  void toggleTeacherMode(){
    state = state.copyWith(
      isTeacher: !state.isTeacher
    );
    ref.read(sharedPreferences).setBool('isTeacher', state.isTeacher);
  }

  void _saveGroupNumbers(Group group){
    final sp = ref.read(sharedPreferences);
    sp.setStringList(
      group.name, state.groups[group]?.map((number)=>'$number').toList() ?? []
    );
  }

  void setGroupNumbers(Group group, Set<int> numbers){
    final newGroups = GroupsMap.from(state.groups)..update(group, (value) => numbers);
    // final newGroups = state.groups..update(group, (value) => numbers).toSet();
    ref.read(ScheduleProvider.instance).value?.filter(newGroups);
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

    ref.read(ScheduleProvider.instance).value?.filter(newGroups);
    // ref.read(ScheduleProvider.instance).whenData((schedule) {
    //   schedule.filter(newGroups);
    //   state = state.copyWith(
    //     groups: newGroups
    //   );
    //
    //     _saveGroupNumbers(group);
    // });

    state = state.copyWith(
      groups: newGroups
    );

    _saveGroupNumbers(group);
  }

  void changeSpecialization(int key){
    state = state.copyWith(
      specializationKey: key
    );
    ref.read(sharedPreferences).setInt('specialization', key);
  }

}