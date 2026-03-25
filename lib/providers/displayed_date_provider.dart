import 'package:ezak/providers/dates_provider.dart';
import 'package:ezak/providers/initial_date_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//todo add checking if was current day, but should be now changed

class DisplayedDateProvider extends AsyncNotifier<DateTime>{
  static final instance = AsyncNotifierProvider(DisplayedDateProvider.new);
  @override
  Future<DateTime> build() async{
    return ref.watch(initialDateProvider.future);
  }

  void change(DateTime newDate){
    state = AsyncValue.data(newDate);
  }

  Future next() async{
    final dates = await ref.read(datesProvider.future);
    final current = state.value;
    if(current!=null && current!=dates.last){
      state = AsyncValue.data(dates.firstWhere((element) => element.isAfter(current)));
    }
  }

  Future previous() async{
    final dates = await ref.read(datesProvider.future);
    final current = state.value;
    if(current!=null && current!=dates.first){
      state = AsyncValue.data(dates.lastWhere((element) => element.isBefore(current)));
    }
  }

}
