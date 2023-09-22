import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.g.dart';
import 'l10n_pl.g.dart';

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.g.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @caption.
  ///
  /// In pl, this message translates to:
  /// **'{appName}™️ jest klonem aplikacji e-Student Nysa, i istnieje by dostarczać plan naszych zajęć jeszcze wygodniej!'**
  String caption(String appName);

  /// No description provided for @choose_courses_date.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz datę zajęć'**
  String get choose_courses_date;

  /// No description provided for @university_website.
  ///
  /// In pl, this message translates to:
  /// **'Strona uczelni'**
  String get university_website;

  /// No description provided for @mail_us.
  ///
  /// In pl, this message translates to:
  /// **'Napisz do nas'**
  String get mail_us;

  /// No description provided for @date_selection.
  ///
  /// In pl, this message translates to:
  /// **'Wybór daty'**
  String get date_selection;

  /// No description provided for @informations.
  ///
  /// In pl, this message translates to:
  /// **'Informacje'**
  String get informations;

  /// No description provided for @theme_change.
  ///
  /// In pl, this message translates to:
  /// **'Zmiana motywu'**
  String get theme_change;

  /// No description provided for @previous_day.
  ///
  /// In pl, this message translates to:
  /// **'Poprzedni dzień'**
  String get previous_day;

  /// No description provided for @next_day.
  ///
  /// In pl, this message translates to:
  /// **'Następny dzień'**
  String get next_day;

  /// No description provided for @language.
  ///
  /// In pl, this message translates to:
  /// **'Język'**
  String get language;

  /// No description provided for @academic_teacher_mode.
  ///
  /// In pl, this message translates to:
  /// **'Tryb nauczyciela'**
  String get academic_teacher_mode;

  /// No description provided for @specialization.
  ///
  /// In pl, this message translates to:
  /// **'Specjalizacja'**
  String get specialization;

  /// No description provided for @no_matches_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono dopasowań'**
  String get no_matches_found;

  /// No description provided for @error_occurred.
  ///
  /// In pl, this message translates to:
  /// **'Wystąpił błąd:'**
  String get error_occurred;

  /// No description provided for @no_group_or_specialization.
  ///
  /// In pl, this message translates to:
  /// **'Nie ma nic do wyświetlenia. Upewnij się, że wybrałeś swoją grupę, lub specjalizację.'**
  String get no_group_or_specialization;

  /// No description provided for @legend.
  ///
  /// In pl, this message translates to:
  /// **'Legenda'**
  String get legend;

  /// No description provided for @group_name.
  ///
  /// In pl, this message translates to:
  /// **'{group, select, lecture{Wykład} exercises{Ćwiczenia} laboratories{Laboratoria} project{Projekt} seminar{Seminarium} other{Inny}}'**
  String group_name(String group);

  /// No description provided for @change_language_if_you_like.
  ///
  /// In pl, this message translates to:
  /// **'Zmień język, jeśli chcesz'**
  String get change_language_if_you_like;

  /// No description provided for @set_whether_you_are_a_teacher.
  ///
  /// In pl, this message translates to:
  /// **'Ustaw, czy jesteś nauczycielem'**
  String get set_whether_you_are_a_teacher;

  /// No description provided for @choose_specialization.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz specjalizację / wykładowcę'**
  String get choose_specialization;

  /// No description provided for @go_to_schedule.
  ///
  /// In pl, this message translates to:
  /// **'Przejdź do planu zajęć'**
  String get go_to_schedule;

  /// No description provided for @show_on_map.
  ///
  /// In pl, this message translates to:
  /// **'Pokaż na mapie'**
  String get show_on_map;

  /// No description provided for @settings.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia'**
  String get settings;

  /// No description provided for @about_app.
  ///
  /// In pl, this message translates to:
  /// **'O aplikacji'**
  String get about_app;

  /// No description provided for @schedule_update_prompt.
  ///
  /// In pl, this message translates to:
  /// **'W jaki sposób chcesz zaktualizować plan?'**
  String get schedule_update_prompt;

  /// No description provided for @force_schedule_redownload.
  ///
  /// In pl, this message translates to:
  /// **'Wymuś ponowne pobranie planu'**
  String get force_schedule_redownload;

  /// No description provided for @check_for_schedule_update.
  ///
  /// In pl, this message translates to:
  /// **'Sprawdź aktualność planu'**
  String get check_for_schedule_update;

  /// No description provided for @online_course.
  ///
  /// In pl, this message translates to:
  /// **'Zajęcia zdalne'**
  String get online_course;

  /// No description provided for @full_time_course.
  ///
  /// In pl, this message translates to:
  /// **'Zajęcia stacjonarne'**
  String get full_time_course;

  /// No description provided for @building_and_room.
  ///
  /// In pl, this message translates to:
  /// **'Budynek {building}, sala {room}'**
  String building_and_room(String building, int room);

  /// No description provided for @lecturer.
  ///
  /// In pl, this message translates to:
  /// **'Wykładowca'**
  String get lecturer;

  /// No description provided for @group.
  ///
  /// In pl, this message translates to:
  /// **'Grupa'**
  String get group;

  /// No description provided for @longer_break.
  ///
  /// In pl, this message translates to:
  /// **'Dłuższa przerwa'**
  String get longer_break;

  /// No description provided for @from_hour.
  ///
  /// In pl, this message translates to:
  /// **'Od {hour}'**
  String from_hour(String hour);

  /// No description provided for @to_hour.
  ///
  /// In pl, this message translates to:
  /// **'Do {hour}'**
  String to_hour(String hour);
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return L10nEn();
    case 'pl': return L10nPl();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
