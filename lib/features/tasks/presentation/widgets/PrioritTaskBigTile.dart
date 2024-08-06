import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/deletes.dart';
import 'package:task_manager/features/tasks/presentation/screens/EditDailyTask.dart';
import 'package:task_manager/features/tasks/presentation/screens/editPriorityTask.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';

class Priorittaskbigtile extends StatelessWidget {
  final Prioritytask prioritytask;
  const Priorittaskbigtile({super.key, required this.prioritytask});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 0.1,
                offset: const Offset(0, 2))
          ],
          border: Border(
              left: BorderSide(
                  color: const Color(0xffABCEF5).withOpacity(0.5), width: 1.5),
              right: BorderSide(
                  color: const Color(0xffABCEF5).withOpacity(0.5), width: 1.5),
              top: BorderSide(
                  color: const Color(0xffABCEF5).withOpacity(0.5), width: 1.5),
              bottom: BorderSide(
                  color: const Color(0xffABCEF5).withOpacity(0.5), width: 1.5)),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    prioritytask.icon == null
                        ? SvgPicture.asset(
                            "lib/core/assets/icons/default.svg",
                            width: 30,
                          )
                        : prioritytask.icon!,
                    const SizedBox(
                      width: 10,
                    ),
                    Text(prioritytask.title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Appcolors.brandColor)),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => editDialog(
                              task: prioritytask,
                            ));
                  },
                  icon: const Icon(Icons.more_horiz),
                  color: Appcolors.brandColor,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              prioritytask.description,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${DateFormat.MMMd().format(prioritytask.startDate)} - ${DateFormat.MMMd().format(prioritytask.endDate)}",
                style: const TextStyle(
                    fontSize: 13,
                    color: Appcolors.brandColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class editDialog extends ConsumerWidget {
  final Prioritytask task;
  const editDialog({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskmanagementRepository = TaskmanagementRepositoryImplementation(
        remoteDataSource: RemoteDataSource(ref),
        localDataSource: LocalDataSource());
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.27,
                      vertical: MediaQuery.of(context).size.height * 0.015)),
                  backgroundColor:
                      const WidgetStatePropertyAll(Appcolors.brandColor),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Editprioritytask(prioritytask: task)));
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.25,
                      vertical: MediaQuery.of(context).size.height * 0.013)),
                  backgroundColor:
                      const WidgetStatePropertyAll(Appcolors.brandColor),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  DeletePriorityTaskUsecase(taskmanagementRepository)
                      .call(task);

                  showDialog(
                      context: context,
                      builder: (context) => const deletedDialog());
                  ref.invalidate(priorityTasksStateProvider);
                  ref.refresh(priorityTasksStateProvider(ref));
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}

class deletedDialog extends StatefulWidget {
  const deletedDialog({super.key});

  @override
  State<deletedDialog> createState() => _deletedDialogState();
}

class _deletedDialogState extends State<deletedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Appcolors.brandColor.withOpacity(_animation.value),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                )),
            const Text(
              "Task Deleted Successfully",
              style: TextStyle(
                  color: Appcolors.brandColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 19),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.25,
                      vertical: MediaQuery.of(context).size.height * 0.013)),
                  backgroundColor:
                      const WidgetStatePropertyAll(Appcolors.brandColor),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  // DeleteDailyTaskUsecase(taskmanagementRepository)
                  //     .call(dailytask);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Back",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                )),
          ],
        ),
      ),
    );
  }
}
