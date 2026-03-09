import 'dart:async';

import 'package:ezak/l10n/l10n.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

extension PlatformExtensions on TargetPlatform{
  bool isMobile(){
    return /*kIsWeb? false:*/
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.fuchsia ||
      defaultTargetPlatform == TargetPlatform.iOS;
  }
}

extension DateTimeExtension on DateTime{
  String toLocaleString(Locale locale){
    return DateFormat.yMd(locale.languageCode).format(this);
  }

  bool get isAprilFoolsDay => month == 4 && day == 1;

  bool get isToday {
    final today = DateTime.now();
    return year == today.year && month == today.month && day == today.day;
  }

  // int get weekOfMonth {
  //   int sum = firstDayOfMonth.weekday - 1 + day;
  //   if (sum % 7 == 0) {
  //     return sum ~/ 7;
  //   } else {
  //     return sum ~/ 7 + 1;
  //   }
  // }
}

extension LocaleExtension on Locale{
  bool isRtl()=> Bidi.isRtlLanguage(languageCode);
}

extension ContentTypeExtension on Response{
  String? get contentType => headers['content-type'];
}

extension TimeOfDayExtension on TimeOfDay{
  int get totalMinutes => hour * TimeOfDay.minutesPerHour + minute;
  static TimeOfDay fromMinutes(int minutes)=> TimeOfDay(
    hour: minutes ~/ TimeOfDay.minutesPerHour,
    minute: minutes % TimeOfDay.minutesPerHour
  );
  bool operator >(TimeOfDay other) => totalMinutes > other.totalMinutes;
  TimeOfDay operator -(TimeOfDay other) => fromMinutes(totalMinutes - other.totalMinutes);
}

extension DurationToHour on Duration{
  String formatTime(BuildContext context){
    return "${inHours!=0? ('$inHours ${L10n.of(context).short_hour}'):''} ${inMinutes!=0?('${inMinutes.remainder(TimeOfDay.minutesPerHour)} ${L10n.of(context).short_minute}'):''}";
  }
}

extension WcagColor on Color {
  /// contrast factor (from 1.0 to 21.0)
  double contrastRatio(Color background) {
    final l1 = computeLuminance() + 0.05;
    final l2 = background.computeLuminance() + 0.05;

    return l1 > l2 ? l1 / l2 : l2 / l1;
  }

  Color ensureWcagAaContrast(BuildContext context) {
    Color current = this;
    final appBackground = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;

    for (int i = 0; i < 50; i++) {
      final textContrast = current.contrastRatio(textColor);
      final bgContrast = current.contrastRatio(appBackground);

      if (textContrast >= 4.5 && bgContrast >= 3.0) {
        break;
      }

      final hsl = HSLColor.fromColor(current);
      double newLightness = hsl.lightness;

      if (textContrast < 4.5) {
        if (textColor.computeLuminance() < 0.5) {
          newLightness += 0.05;
        } else {
          newLightness -= 0.05;
        }
      } else if (bgContrast < 3.0) {
        if (appBackground.computeLuminance() < 0.5) {
          newLightness += 0.05;
        } else {
          newLightness -= 0.05;
        }
      }

      newLightness = newLightness.clamp(0.0, 1.0);

      if (newLightness == hsl.lightness) break;

      current = hsl.withLightness(newLightness).toColor();
    }

    return current;
  }
}

/// https://riverpod.dev/docs/concepts2/auto_dispose#example-keeping-state-alive-for-a-specific-amount-of-time
extension AutoDisposeRefCache on Ref {
  /// Keeps the provider alive for [duration].
  void cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }
}