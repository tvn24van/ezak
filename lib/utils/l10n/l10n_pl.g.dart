import 'package:intl/intl.dart' as intl;

import 'l10n.g.dart';

/// The translations for Polish (`pl`).
class L10nPl extends L10n {
  L10nPl([String locale = 'pl']) : super(locale);

  @override
  String caption(String appName) {
    return '$appName™️ jest klonem aplikacji e-Student Nysa, i istnieje by dostarczać plan naszych zajęć jeszcze wygodniej!';
  }

  @override
  String get choose_courses_date => 'Wybierz datę zajęć';

  @override
  String get university_website => 'Strona uczelni';

  @override
  String get mail_us => 'Napisz do nas';

  @override
  String get date_selection => 'Wybór daty';

  @override
  String get informations => 'Informacje';

  @override
  String get theme_change => 'Zmiana motywu';

  @override
  String get previous_day => 'Poprzedni dzień';

  @override
  String get next_day => 'Następny dzień';

  @override
  String get language => 'Język';

  @override
  String get academic_teacher_mode => 'Tryb nauczyciela';

  @override
  String get specialization => 'Specjalizacja';

  @override
  String get no_matches_found => 'Nie znaleziono dopasowań';

  @override
  String get error_occurred => 'Wystąpił błąd:';

  @override
  String get no_group_or_specialization => 'Nie ma nic do wyświetlenia. Upewnij się, że wybrałeś swoją grupę, lub specjalizację.';

  @override
  String get legend => 'Legenda';

  @override
  String group_name(String group) {
    String _temp0 = intl.Intl.selectLogic(
      group,
      {
        'lecture': 'Wykład',
        'exercises': 'Ćwiczenia',
        'laboratories': 'Laboratoria',
        'project': 'Projekt',
        'seminar': 'Seminarium',
        'other': 'Inny',
      },
    );
    return '$_temp0';
  }

  @override
  String get change_language_if_you_like => 'Zmień język, jeśli chcesz';

  @override
  String get set_whether_you_are_a_teacher => 'Ustaw, czy jesteś nauczycielem';

  @override
  String get choose_specialization => 'Wybierz specjalizację / wykładowcę';

  @override
  String get go_to_schedule => 'Przejdź do planu zajęć';

  @override
  String get show_on_map => 'Pokaż na mapie';

  @override
  String get settings => 'Ustawienia';

  @override
  String get about_app => 'O aplikacji';

  @override
  String get schedule_update_prompt => 'W jaki sposób chcesz zaktualizować plan?';

  @override
  String get force_schedule_redownload => 'Wymuś ponowne pobranie planu';

  @override
  String get check_for_schedule_update => 'Sprawdź aktualność planu';

  @override
  String get online_course => 'Zajęcia zdalne';

  @override
  String get full_time_course => 'Zajęcia stacjonarne';

  @override
  String building_and_room(String building, int room) {
    return 'Budynek $building, sala $room';
  }

  @override
  String get lecturer => 'Wykładowca';

  @override
  String get group => 'Grupa';

  @override
  String get longer_break => 'Dłuższa przerwa';

  @override
  String from_hour(String hour) {
    return 'Od $hour';
  }

  @override
  String to_hour(String hour) {
    return 'Do $hour';
  }
}
