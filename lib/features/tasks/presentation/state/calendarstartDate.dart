import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'calendarstartDate.g.dart';

@riverpod
class calendarStartdate extends _$calendarStartdate {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void changeDate(DateTime newDate) {
    state = newDate;
  }
}

@riverpod
class filterState extends _$filterState {
  @override
  bool build() {
    return false;
  }

  void changeFilter(bool newFilter) {
    state = newFilter;
  }
}
