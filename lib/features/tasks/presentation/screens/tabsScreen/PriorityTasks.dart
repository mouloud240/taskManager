import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';
import 'package:task_manager/features/tasks/presentation/state/calendarstartDate.dart';
import 'package:task_manager/features/tasks/presentation/widgets/PrioritTaskBigTile.dart';

class PrioritytasksTab extends ConsumerStatefulWidget {
  const PrioritytasksTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrioritytasksTabState();
}

class _PrioritytasksTabState extends ConsumerState<PrioritytasksTab> {
  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(filterStateProvider);
    final asyncVal = ref.watch(priorityTasksStateProvider(ref));
    final finalDate = ref.watch(calendarStartdateProvider);
    return asyncVal.when(
        data: (res) {
          return res.fold((fail) => Text(fail.errMessage), (tasks) {
            if (filter) {
              tasks = tasks
                  .where((element) => element.endDate.compareTo(finalDate) < 0)
                  .toList();
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Priorittaskbigtile(prioritytask: tasks[index]);
                });
          });
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const SizedBox(
            width: 40, height: 40, child: CircularProgressIndicator()));
  }
}
