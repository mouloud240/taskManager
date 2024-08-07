import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/presentation/screens/CreatenewTask.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';
import 'package:task_manager/features/tasks/presentation/state/calendarstartDate.dart';
import 'package:task_manager/features/tasks/presentation/widgets/DailyTaskBigTile.dart';

class DailytasksTab extends ConsumerStatefulWidget {
  const DailytasksTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DailytasksTabState();
}

class _DailytasksTabState extends ConsumerState<DailytasksTab> {
  @override
  Widget build(BuildContext context) {
    final asyncVal = ref.watch(dailyTasksStateProvider(ref));
    final filter = ref.watch(filterStateProvider);
    final finalDate = ref.watch(calendarStartdateProvider);
    return asyncVal.when(
        data: (res) {
          return res.fold((fail) => Text(fail.errMessage), (tasks) {
            if (filter) {
              tasks = tasks
                  .where((element) => element.endDate.compareTo(finalDate) <= 0)
                  .toList();
            }
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) =>
                  Dailytaskbigtile(dailytask: tasks[index]),
            );
          });
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () {
          return const SizedBox(
              width: 40, height: 40, child: CircularProgressIndicator());
        });
  }
}
