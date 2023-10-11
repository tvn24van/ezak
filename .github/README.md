[![Crowdin](https://badges.crowdin.net/e_student_clone/localized.svg)](https://crowdin.com/project/ezak)

# **ezak**
- Unofficial app for viewing schedule for PANS in Nysa
- Nieoficjalna aplikacja do przeglądania planu PANS w Nysie

## Downloads
- [Android (Google Play)](https://play.google.com/store/apps/details?id=pl.tvn24van.ezak)
- [Windows 10/11 (Microsoft Store)](https://www.microsoft.com/store/apps/9NGGHP8GX2CB)
- [Other platforms (<u>SOON</u>)](https://github.com/tvn24van/ezak/releases/latest)

## TODOs

- refactor data loading
- translations for ~~Polish~~, ~~english~~, ukrainian and maybe hungarian too?
- in desktop computers set title to *app name* - day, 21-02-2023 for e.g.
- maybe add updating desktop versions using https://pub.dev/packages/updat
- add keys shortcuts for switching currently displayed day, etc
- maybe someday home screen widgets to see schedule even without opening app thus
this is only possible with platform-specified code

## Generating code
- for translations `flutter gen-l10n` or run _gen_l10n.sh
- for splash `flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml`
- for classes `flutter pub run build_runner build`
- for icons `flutter pub run flutter_launcher_icons`

## Building
- `flutter build <platform> --release`
- for Microsoft Store `dart run msix:create`