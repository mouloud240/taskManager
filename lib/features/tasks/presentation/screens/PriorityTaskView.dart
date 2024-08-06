import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_spacing/responsive_spacing.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';
import 'package:task_manager/features/tasks/presentation/widgets/Mini_taskTile.dart';
import 'package:task_manager/features/tasks/presentation/widgets/Priority_taskTile.dart';

class Prioritytaskview extends ConsumerStatefulWidget {
  Prioritytask model;
  Prioritytaskview({super.key, required this.model});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrioritytaskviewState();
}

class _PrioritytaskviewState extends ConsumerState<Prioritytaskview> {
  final List<Minitask> minitakssList = [];

  @override
  void initState() {
    super.initState();
    widget.model.miniTasksList.forEach((key, value) {
      minitakssList.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = widget.model.getdiffernce();

    final asyncval = ref.watch(priorityTasksStateProvider(ref));
    return ResponsiveScaffold(
      appBar: AppBar(
        leading: widget.model.icon == null
            ? SvgPicture.asset(
                'lib/core/assets/icons/default.svg',
                width: 20,
                height: 20,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.model.icon,
              ),
        title: Text(
          widget.model.title,
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Appcolors.brandColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                backgroundColor:
                    const WidgetStatePropertyAll(Appcolors.brandColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(priorityTasksStateProvider(ref));
        },
        child: ListView(children: [
          asyncval.when(
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
            data: (data) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Start",
                            style: TextStyle(
                                color: Appcolors.subHeaderColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          Text(
                            DateFormat.yMMMd().format(widget.model.startDate),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "End",
                            style: TextStyle(
                                color: Appcolors.subHeaderColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          Text(DateFormat.yMMMd().format(widget.model.endDate),
                              style: const TextStyle(
                                fontSize: 16,
                              ))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.288,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                            color: Appcolors.brandColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(remainingTime["months"].toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700)),
                            const Text(
                              "months",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.032,
                        child: const Center(
                          child: Text(
                            "-",
                            style: TextStyle(
                              color: Color(0xff9CCAFE),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.288,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                            color: Appcolors.brandColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(remainingTime['days'].toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700)),
                            const Text(
                              "days",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.032,
                        child: const Center(
                          child: Text(
                            "-",
                            style: TextStyle(
                              color: Color(0xff9CCAFE),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.288,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                            color: Appcolors.brandColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(remainingTime['hours'].toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700)),
                            const Text(
                              "hours",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(
                        color: Appcolors.headerColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.model.description,
                    style: const TextStyle(
                        color: Appcolors.subHeaderColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Progress",
                    style: TextStyle(
                        color: Appcolors.headerColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  ProgressBar(
                    displayprogress: true,
                    prioritytask: widget.model,
                    width: MediaQuery.of(context).size.width * 0.9,
                    foreground: Appcolors.brandColor,
                    background: const Color.fromARGB(220, 158, 158, 158),
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  const Text(
                    "To do List",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Appcolors.subHeaderColor),
                  ),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MiniTasktile(
                          minitask: minitakssList[index],
                          prioritytask: widget.model,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: widget.model.miniTasksList.length),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
