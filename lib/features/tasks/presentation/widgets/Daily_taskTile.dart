import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/createNewDailyUsecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/deletes.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';

class DailyTasktile extends ConsumerStatefulWidget {
  final Dailytask dailyTask;
  const DailyTasktile({super.key, required this.dailyTask});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DailyTasktileState();
}

class _DailyTasktileState extends ConsumerState<DailyTasktile> {
  late bool status;

  @override
  void initState() {
    super.initState();
    status = widget.dailyTask.status;
  }

  @override
  Widget build(BuildContext context) {
    final taskManage = TaskmanagementRepositoryImplementation(
        remoteDataSource: RemoteDataSource(ref),
        localDataSource: LocalDataSource());

    return GestureDetector(
      onLongPress: () {
        DeleteDailyTaskUsecase(taskManage).call(widget.dailyTask);
        ref.invalidate(dailyTasksStateProvider);
      },
      onTap: () async {
        setState(() {
          status = !status; // Update the local status
        });

        // Log before updating Firebase
        print("Updating task status in Firebase");
        // Update the task status in Firebase
        final result = await Createnewdailyusecase(taskManage).call(Dailytask(
          title: widget.dailyTask.title,
          description: widget.dailyTask.description,
          startDate: widget.dailyTask.startDate,
          endDate: widget.dailyTask.endDate,
          id: widget.dailyTask.id,
          status: status,
        ));

        // Log result
        result.fold(
          (failure) {
            print("Error updating task: ${failure.errMessage}");
            setState(() {
              status = !status; // Revert status change on error
            });
          },
          (_) => print("Task updated successfully"),
        );

        // Refresh the state
        ref.refresh(DailyTasksStateProvider(ref));
      },
      child: GestureDetector(
        child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset.zero, blurRadius: 3)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    widget.dailyTask.title,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: status ? Appcolors.brandColor : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                SvgPicture.asset(status
                    ? "lib/core/assets/icons/checked.svg"
                    : "lib/core/assets/icons/unchecked.svg")
              ],
            )),
      ),
    );
  }
}
