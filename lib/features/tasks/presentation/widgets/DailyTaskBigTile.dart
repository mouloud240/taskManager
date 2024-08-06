import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_spacing/responsive_spacing.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/deletes.dart';
import 'package:task_manager/features/tasks/presentation/screens/EditDailyTask.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';

class Dailytaskbigtile extends ConsumerWidget {
  final Dailytask dailytask;
  const Dailytaskbigtile({super.key, required this.dailytask});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => editDialog(
                    dailytask: dailytask,
                  ));
        },
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: const Color(0xffABCEF5).withOpacity(0.5)),
                right:
                    BorderSide(color: const Color(0xffABCEF5).withOpacity(0.5)),
                left:
                    BorderSide(color: const Color(0xffABCEF5).withOpacity(0.5)),
                top:
                    BorderSide(color: const Color(0xffABCEF5).withOpacity(0.5)),
              ),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Text(
              dailytask.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            )),
      ),
    );
  }
}

class editDialog extends ConsumerWidget {
  final Dailytask dailytask;
  const editDialog({super.key, required this.dailytask});

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Editdailytask(
                      dailytask: dailytask,
                    );
                  }));
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
                  DeleteDailyTaskUsecase(taskmanagementRepository)
                      .call(dailytask);
                  ref.invalidate(dailyTasksStateProvider);
                  ref.refresh(DailyTasksStateProvider(ref));
                  showDialog(
                      context: context,
                      builder: (context) => const deletedDialog());
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
