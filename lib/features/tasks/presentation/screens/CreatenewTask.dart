import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/createNewDailyUsecase.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class Createnewtask extends ConsumerStatefulWidget {
  const Createnewtask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatenewtaskState();
}

String selectedType = "Daily";
const Uuid uuid = Uuid();
late TextEditingController titleController;
late TextEditingController descriptionController;

class _CreatenewtaskState extends ConsumerState<Createnewtask> {
  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taksmanagementrepo = TaskmanagementRepositoryImplementation(
        localDataSource: LocalDataSource(),
        remoteDataSource: RemoteDataSource(ref));
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 150,
        centerTitle: true,
        title: const Text(
          "Add Task",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Appcolors.brandColor,
        leading: IconButton(
            style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Appcolors.brandColor,
            )),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Appcolors.brandColor,
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            "Start",
                            style: TextStyle(
                                color: Appcolors.brandColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(Size(
                                    MediaQuery.of(context).size.width * 0.44,
                                    MediaQuery.of(context).size.height *
                                        0.059)),
                                backgroundColor: const WidgetStatePropertyAll(
                                    Color(0xffEEF5FD)),
                                side: WidgetStatePropertyAll(BorderSide(
                                    color: const Color(0xff006EE9)
                                        .withOpacity(0.06),
                                    width: 3)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Appcolors.brandColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Feb-21-2022",
                                  style: TextStyle(
                                      color: Appcolors.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Text(
                            "End",
                            style: TextStyle(
                                color: Appcolors.brandColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(Size(
                                    MediaQuery.of(context).size.width * 0.44,
                                    MediaQuery.of(context).size.height *
                                        0.059)),
                                backgroundColor:
                                    const WidgetStatePropertyAll(Colors.white),
                                side: WidgetStatePropertyAll(BorderSide(
                                    color: const Color(0xff006EE9)
                                        .withOpacity(0.06),
                                    width: 3)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Appcolors.brandColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Mar-3-2022",
                                  style: TextStyle(
                                      color: Appcolors.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Title",
                  style: TextStyle(
                      color: Appcolors.brandColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      focusColor: const Color(0xff006EE9).withOpacity(0.06),
                      hintText: "Enter Title",
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 10),
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Category",
                  style: TextStyle(
                      color: Appcolors.brandColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = "Priority";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        decoration: BoxDecoration(
                          color: selectedType == "Priority"
                              ? Appcolors.brandColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: const Color(0xff006EE9).withOpacity(0.1),
                              width: 2,
                              style: BorderStyle.solid),
                        ),
                        child: Text(
                          "Priority Task",
                          style: TextStyle(
                              color: selectedType == "Priority"
                                  ? Colors.white
                                  : Appcolors.brandColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = "Daily";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        decoration: BoxDecoration(
                          color: selectedType == "Daily"
                              ? Appcolors.brandColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: const Color(0xff006EE9).withOpacity(0.1),
                              width: 2,
                              style: BorderStyle.solid),
                        ),
                        child: Text(
                          "Daily Task",
                          style: TextStyle(
                              color: selectedType == "Daily"
                                  ? Colors.white
                                  : Appcolors.brandColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                      color: Appcolors.brandColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      focusColor: const Color(0xff006EE9).withOpacity(0.06),
                      hintText: "Enter Description",
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 10),
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 15,
                ),
                Visibility(
                    visible: selectedType == "Priority",
                    child: Container(
                      child: const Text("Mini tasks"),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all(Size(
                            MediaQuery.of(context).size.width * 0.9,
                            MediaQuery.of(context).size.height * 0.06)),
                        backgroundColor: WidgetStateProperty.all(
                            Appcolors.brandColor.withOpacity(0.9)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                    onPressed: () {
                      if (selectedType == "Daily") {
                        Createnewdailyusecase(taksmanagementrepo).call(
                            Dailytask(
                                title: titleController.text,
                                description: descriptionController.text,
                                startDate: startDate,
                                endDate: endDate,
                                id: uuid.v4(),
                                status: false));
                        ref.invalidate(dailyTasksStateProvider);
                        ref.refresh(dailyTasksStateProvider(ref));
                        Navigator.of(context).pop();
                      } else if (selectedType == "Priority") {
                        print("Create Prio");
                      }
                    },
                    child: const Text(
                      "Create Task",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
