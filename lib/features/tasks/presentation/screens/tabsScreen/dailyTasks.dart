import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/presentation/screens/CreatenewTask.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';
import 'package:task_manager/features/tasks/presentation/widgets/DailyTaskBigTile.dart';

class DailytasksTab extends ConsumerStatefulWidget {
  const DailytasksTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DailytasksTabState();
}

final List<Dailytask> testDailyTasks = [
  Dailytask(
      title: "Work Out",
      description: "Working Out",
      startDate: DateTime.now(),
      endDate: endDate,
      id: "5",
      status: false),
  Dailytask(
      title: "Learn Coding",
      description: "Learn to Code",
      startDate: DateTime.now(),
      endDate: endDate,
      id: "9",
      status: false),
];

class _DailytasksTabState extends ConsumerState<DailytasksTab> {
  @override
  Widget build(BuildContext context) {
    final asyncVal = ref.watch(dailyTasksStateProvider(ref));
    return asyncVal.when(
        data: (res) {
          return res.fold((fail) => Text(fail.errMessage), (tasks) {
            return ListView.separated(
              itemCount: tasks.length,
              separatorBuilder: (context, index) => SizedBox(
                height: MediaQuery.of(context).size.height * 0,
              ),
              itemBuilder: (context, index) =>
                  Dailytaskbigtile(dailytask: tasks[index]),
            );
          });
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () {
          return const CircularProgressIndicator();
        });
  }
}