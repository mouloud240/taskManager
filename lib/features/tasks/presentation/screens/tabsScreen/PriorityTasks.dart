import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';
import 'package:task_manager/features/tasks/presentation/widgets/PrioritTaskBigTile.dart';
import 'package:task_manager/features/tasks/presentation/widgets/Priority_taskTile.dart';

class PrioritytasksTab extends ConsumerStatefulWidget {
  const PrioritytasksTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrioritytasksTabState();
}

final List<Prioritytask> _prioritTasksTest = [
  Prioritytask(
      miniTasksList: {},
      title: "UI Design",
      description:
          "User interface (UI) design is the process designers use to build interfaces in software or computerized devices, focusing on looks or style. Designers aim to create interfaces which users find easy to use and pleasurable. UI design refers to graphical user interfaces and other forms e.g., voice-controlled interfaces.",
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 2)),
      id: '5',
      status: false)
];

class _PrioritytasksTabState extends ConsumerState<PrioritytasksTab> {
  @override
  Widget build(BuildContext context) {
    final asyncVal = ref.watch(priorityTasksStateProvider(ref));
    return asyncVal.when(
        data: (res) {
          return res.fold((fail) => Text(fail.errMessage), (tasks) {
            return ListView.builder(
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
