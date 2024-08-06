import 'package:flutter/material.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';

class Priorittaskbigtile extends StatelessWidget {
  final Prioritytask prioritytask;
  const Priorittaskbigtile({super.key, required this.prioritytask});

  @override
  Widget build(BuildContext context) {
    return Text(prioritytask.description);
  }
}
