import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/createNewDailyUsecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/updates.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';

class MiniTasktile extends ConsumerStatefulWidget {
  final Minitask minitask;
  final Prioritytask prioritytask;
  const MiniTasktile(
      {required this.prioritytask, super.key, required this.minitask});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MiniTasktileState();
}

class _MiniTasktileState extends ConsumerState<MiniTasktile> {
  late bool status;

  @override
  void initState() {
    super.initState();
    status = widget.minitask.status;
  }

  @override
  Widget build(BuildContext context) {
    final taskManage = TaskmanagementRepositoryImplementation(
        remoteDataSource: RemoteDataSource(ref),
        localDataSource: LocalDataSource());

    return GestureDetector(
      onTap: () async {
        setState(() {
          status = !status;
          widget.minitask.status = status;
        });
        await EditTaskInpriorityUsecase(taskManage).call(
            widget.prioritytask,
            Minitask(
              name: widget.minitask.name,
              id: widget.minitask.id,
              status: status,
            ));
        ref.invalidate(dailyTasksStateProvider);
        ref.invalidate(priorityTasksStateProvider);
        return ref.refresh(priorityTasksStateProvider(ref));
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  overflow: TextOverflow.clip,
                  widget.minitask.name,
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
    );
  }
}
