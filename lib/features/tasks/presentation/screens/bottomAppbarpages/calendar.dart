import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Calendar"),);
  }
}