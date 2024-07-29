import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/createNewDailyUsecase.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';

class DailyTasktile extends ConsumerStatefulWidget {
  final Dailytask dailyTask;
  const DailyTasktile({super.key, required this.dailyTask});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DailyTasktileState();
}

class _DailyTasktileState extends ConsumerState<DailyTasktile> {
  @override
  Widget build(BuildContext context) {
    final taskManage = TaskmanagementRepositoryImplementation(
        remoteDataSource: RemoteDataSource(ref),
        localDataSource: LocalDataSource());
    return GestureDetector(
      onTap: () {
        // ignore: invalid_use_of_protected_member
        setState(() {
          widget.dailyTask.status = !widget.dailyTask.status;
        });
        Createnewdailyusecase(taskManage).call(widget.dailyTask);
        ref.refresh(DailyTasksStateProvider(ref));
      },
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
              Text(
                widget.dailyTask.description,
                style: TextStyle(
                    color: widget.dailyTask.status
                        ? Appcolors.brandColor
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              SvgPicture.asset(widget.dailyTask.status
                  ? "lib/core/assets/icons/checked.svg"
                  : "lib/core/assets/icons/unchecked.svg")
            ],
          )),
    );
  }
}
