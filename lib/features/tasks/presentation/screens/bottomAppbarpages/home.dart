import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';
import 'package:task_manager/features/tasks/presentation/widgets/Daily_taskTile.dart';
import 'package:task_manager/features/tasks/presentation/widgets/Priority_taskTile.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final userValue = ref.watch(userStateProvider);
    final dailyValue = ref.watch(dailyTasksStateProvider(ref));
    final priorityValue = ref.watch(priorityTasksStateProvider(ref));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userValue.when(
              data: (data) {
                String getFirstWord(String? input) {
                  List<String> words = input!.split(' ');
                  return words.isNotEmpty ? words[0] : '';
                }

                String name = getFirstWord(data!.username);
                return Text(
                  "Welcome $name",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Appcolors.headerColor,
                    fontSize: 25,
                  ),
                );
              },
              error: (error, stackTrace) => const Text("Error"),
              loading: () => const CircularProgressIndicator()),
          const Text(
            "Have a nice day!",
            style: TextStyle(
                color: Appcolors.subHeaderColor,
                fontSize: 18,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "My Priority Tasks",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          priorityValue.when(
            data: (res) {
              return res.fold((fail) => Text(fail.errMessage), (tasks) {
                tasks.sort((a, b) => a.endDate.compareTo(b.endDate));
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PriorityTasktile(prioritytask: tasks[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: tasks.length),
                );
              });
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Daily Tasks",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          dailyValue.when(
              data: (data) {
                return data.fold((fai) {
                  return Text(fai.errMessage);
                }, (tasks) {
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return DailyTasktile(dailyTask: tasks[index]);
                      });
                });
              },
              error: (error, stackTrace) => const Text("Error"),
              loading: () => const CircularProgressIndicator())
        ],
      ),
    );
  }
}
