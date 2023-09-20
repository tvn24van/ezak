import 'package:intl/intl.dart' as intl;

import 'l10n.g.dart';

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String caption(String appName) {
    return '$appName™️ is a clone of e-Student Nysa app, and exists to deliver our schedule even faster and more convenient!';
  }

  @override
  String get choose_courses_date => 'Select a class date';

  @override
  String get university_website => 'University\'s website';

  @override
  String get mail_us => 'Mail us';

  @override
  String get date_selection => 'Date selection';

  @override
  String get informations => 'Info';

  @override
  String get theme_change => 'Theme change';

  @override
  String get previous_day => 'Previous day';

  @override
  String get next_day => 'Next day';

  @override
  String get language => 'Language';

  @override
  String get academic_teacher_mode => 'Teacher mode';

  @override
  String get specialization => 'Specialization';

  @override
  String get error_occurred => 'An error occurred:';

  @override
  String get no_group_or_specialization => 'There is nothing to show. Make sure you have selected your group, or specialization.';

  @override
  String get legend => 'Legend';

  @override
  String group_name(String group) {
    String _temp0 = intl.Intl.selectLogic(
      group,
      {
        'lecture': 'Lecture',
        'exercises': 'Exercises',
        'laboratories': 'Laboratories',
        'project': 'Project',
        'seminar': 'Seminar',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String get change_language_if_you_like => 'Change language if you like';

  @override
  String get set_whether_you_are_a_teacher => 'Set whether you are a teacher';

  @override
  String get choose_specialization => 'Choose specialization / lecturer';

  @override
  String get go_to_schedule => 'Go to schedule';

  @override
  String get show_on_map => 'Show on map';

  @override
  String get settings => 'Settings';

  @override
  String get about_app => 'About app';

  @override
  String get schedule_update_prompt => 'How do you want to update schedule?';

  @override
  String get force_schedule_redownload => 'Force schedule redownload';

  @override
  String get check_for_schedule_update => 'Check schedule for updates';

  @override
  String get online_course => 'Remote classes';

  @override
  String get full_time_course => 'Full-time classes';

  @override
  String building_and_room(String building, int room) {
    return 'Building $building, room $room';
  }

  @override
  String get lecturer => 'Lecturer';

  @override
  String get group => 'Group';

  @override
  String get longer_break => 'Longer break';

  @override
  String from_hour(String hour) {
    return 'From $hour';
  }

  @override
  String to_hour(String hour) {
    return 'To $hour';
  }
}
