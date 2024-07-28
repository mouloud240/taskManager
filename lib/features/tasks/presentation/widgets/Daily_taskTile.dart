import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyTasktile extends ConsumerStatefulWidget {
  final DailyTasktile dailyTasktile;
  const DailyTasktile({super.key, required this.dailyTasktile});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DailyTasktileState();
}

class _DailyTasktileState extends ConsumerState<DailyTasktile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
