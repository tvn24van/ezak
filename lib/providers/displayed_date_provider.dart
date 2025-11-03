import 'package:ezak/providers/initial_date_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//todo add checking if was current day, but should be now changed

class DisplayedDateProvider extends AsyncNotifier<DateTime>{
  static final instance = AsyncNotifierProvider<DisplayedDateProvider, DateTime>(DisplayedDateProvider.new);
  @override
  Future<DateTime> build() async{
    return ref.watch(initialDateProvider.future);
  }

  void change(DateTime newDate){
    state = AsyncValue.data(newDate);
  }

}
