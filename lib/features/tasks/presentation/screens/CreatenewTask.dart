import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/createNewDailyUsecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/createNewPriorUsecase.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';
import 'package:uuid/uuid.dart';

DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now();
final colors = [
  Colors.red,
  Colors.green,
  Colors.blue[200],
  const Color.fromRGBO(255, 235, 59, 1),
  Colors.purple,
  Colors.pink,
  Colors.orange,
  const Color(0xff362075),
];
final random = Random();

class Createnewtask extends ConsumerStatefulWidget {
  const Createnewtask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatenewtaskState();
}

String selectedType = "Priority";
const Uuid uuid = Uuid();
late TextEditingController titleController;
late TextEditingController descriptionController;

TextEditingController miniTasknameContoller = TextEditingController();
Map<String, Minitask> miniTasks = {
  "0": Minitask(name: "Test", id: "0", status: false),
  "1": Minitask(name: "not Test", id: "1", status: false),
};

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

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              expandedHeight: 120,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  "Add Task",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                centerTitle: true,
              ),
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
                ),
              ),
              backgroundColor: Appcolors.brandColor,
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  color: Appcolors.brandColor,
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SingleChildScrollView(
                      child: Column(
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
                                              MediaQuery.of(context).size.width *
                                                  0.45,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.059)),
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                  Color(0xffEEF5FD)),
                                          side: WidgetStatePropertyAll(
                                              BorderSide(
                                                  color: const Color(0xff006EE9)
                                                      .withOpacity(0.06),
                                                  width: 3)),
                                          shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15)))),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  content: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.84,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.429,
                                                    child: TableCalendar(
                                                      selectedDayPredicate:
                                                          (day) {
                                                        return isSameDay(
                                                            startDate, day);
                                                      },
                                                      calendarStyle:
                                                          const CalendarStyle(
                                                              todayDecoration: BoxDecoration(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              selectedDecoration:
                                                                  BoxDecoration(
                                                                color: Appcolors
                                                                    .brandColor,
                                                                shape: BoxShape
                                                                    .circle,
                                                              )),
                                                      daysOfWeekStyle: const DaysOfWeekStyle(
                                                          weekdayStyle: TextStyle(
                                                              color: Appcolors
                                                                  .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          weekendStyle: TextStyle(
                                                              color: Appcolors
                                                                  .brandColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      weekendDays: const [
                                                        DateTime.friday,
                                                        DateTime.saturday
                                                      ],
                                                      headerStyle:
                                                          const HeaderStyle(
                                                              leftChevronIcon:
                                                                  Icon(
                                                                Icons
                                                                    .arrow_left_sharp,
                                                                color: Appcolors
                                                                    .brandColor,
                                                                size: 40,
                                                              ),
                                                              rightChevronIcon:
                                                                  Icon(
                                                                Icons
                                                                    .arrow_right_sharp,
                                                                color: Appcolors
                                                                    .brandColor,
                                                                size: 40,
                                                              ),
                                                              formatButtonVisible:
                                                                  false,
                                                              titleCentered:
                                                                  true,
                                                              titleTextStyle: TextStyle(
                                                                  color: Appcolors
                                                                      .brandColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                      focusedDay: startDate,
                                                      firstDay: DateTime.utc(
                                                          2010, 01, 01),
                                                      lastDay: DateTime.utc(
                                                          2030, 12, 12),
                                                      onDaySelected:
                                                          (selectedDay,
                                                              focusDay) {
                                                        setState(() {
                                                          startDate =
                                                              selectedDay;
                                                          focusDay =
                                                              selectedDay;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ));
                                            });
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today,
                                            color: Appcolors.brandColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            DateFormat('MMM-dd-yyyy')
                                                .format(startDate),
                                            style: const TextStyle(
                                                color: Appcolors.textColor,
                                                fontSize: 14,
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
                                              MediaQuery.of(context).size.width *
                                                  0.45,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.059)),
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                  Colors.white),
                                          side: WidgetStatePropertyAll(
                                              BorderSide(
                                                  color: const Color(0xff006EE9)
                                                      .withOpacity(0.06),
                                                  width: 3)),
                                          shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15)))),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  content: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.84,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.429,
                                                    child: TableCalendar(
                                                      selectedDayPredicate:
                                                          (day) {
                                                        return isSameDay(
                                                            endDate, day);
                                                      },
                                                      calendarStyle:
                                                          const CalendarStyle(
                                                              todayDecoration: BoxDecoration(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              selectedDecoration:
                                                                  BoxDecoration(
                                                                color: Appcolors
                                                                    .brandColor,
                                                                shape: BoxShape
                                                                    .circle,
                                                              )),
                                                      daysOfWeekStyle: const DaysOfWeekStyle(
                                                          weekdayStyle: TextStyle(
                                                              color: Appcolors
                                                                  .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          weekendStyle: TextStyle(
                                                              color: Appcolors
                                                                  .brandColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      weekendDays: const [
                                                        DateTime.friday,
                                                        DateTime.saturday
                                                      ],
                                                      headerStyle:
                                                          const HeaderStyle(
                                                              leftChevronIcon:
                                                                  Icon(
                                                                Icons
                                                                    .arrow_left_sharp,
                                                                color: Appcolors
                                                                    .brandColor,
                                                                size: 40,
                                                              ),
                                                              rightChevronIcon:
                                                                  Icon(
                                                                Icons
                                                                    .arrow_right_sharp,
                                                                color: Appcolors
                                                                    .brandColor,
                                                                size: 40,
                                                              ),
                                                              formatButtonVisible:
                                                                  false,
                                                              titleCentered:
                                                                  true,
                                                              titleTextStyle: TextStyle(
                                                                  color: Appcolors
                                                                      .brandColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                      focusedDay: endDate,
                                                      firstDay: DateTime.utc(
                                                          2010, 01, 01),
                                                      lastDay: DateTime.utc(
                                                          2030, 12, 12),
                                                      onDaySelected:
                                                          (selectedDay,
                                                              focusDay) {
                                                        setState(() {
                                                          endDate = selectedDay;
                                                          focusDay =
                                                              selectedDay;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ));
                                            });
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today,
                                            color: Appcolors.brandColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            DateFormat('MMM-dd-yyyy')
                                                .format(endDate),
                                            style: const TextStyle(
                                                color: Appcolors.textColor,
                                                fontSize: 14,
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
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xff006EE9)
                                            .withOpacity(0.060),
                                        width: 3)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff006EE9)
                                          .withOpacity(0.06),
                                      width: 3),
                                ),
                                hintText: "Enter Title",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xff006EE9)
                                            .withOpacity(0.06),
                                        width: 10),
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
                                      horizontal: 40, vertical: 17),
                                  decoration: BoxDecoration(
                                    color: selectedType == "Priority"
                                        ? Appcolors.brandColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: const Color(0xff006EE9)
                                            .withOpacity(0.1),
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
                                      horizontal: 40, vertical: 17),
                                  decoration: BoxDecoration(
                                    color: selectedType == "Daily"
                                        ? Appcolors.brandColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: const Color(0xff006EE9)
                                            .withOpacity(0.1),
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
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 5,
                            controller: descriptionController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xff006EE9)
                                            .withOpacity(0.06),
                                        width: 3)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff006EE9)
                                          .withOpacity(0.06),
                                      width: 3),
                                ),
                                hintText: "Enter Description",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xff006EE9)
                                            .withOpacity(0.06),
                                        width: 10),
                                    borderRadius: BorderRadius.circular(25))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Visibility(
                              visible: selectedType == "Priority",
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: miniTasks.keys.length,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 10,
                                      ),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        print(index);
                                        return GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    TextEditingController
                                                        editingController =
                                                        TextEditingController(
                                                            text: miniTasks[index
                                                                    .toString()]!
                                                                .name);
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      content: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.32,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.84,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextField(
                                                                controller:
                                                                    editingController,
                                                                decoration:
                                                                    const InputDecoration(
                                                                        hintText:
                                                                            "Enter Task",
                                                                        enabledBorder: OutlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                                color: Appcolors
                                                                                    .brandColor,
                                                                                width:
                                                                                    2),
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                12))),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Appcolors.brandColor),
                                                                        ),
                                                                        border: OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Appcolors.brandColor),
                                                                            borderRadius: BorderRadius.all(Radius.circular(20)))),
                                                                style: const TextStyle(
                                                                    color: Appcolors
                                                                        .subHeaderColor,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                              ),
                                                              ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        const WidgetStatePropertyAll(
                                                                            Appcolors.brandColor),
                                                                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10))),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      miniTasks[index.toString()]!
                                                                              .name =
                                                                          editingController
                                                                              .text;
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    miniTasknameContoller
                                                                        .clear();
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            65,
                                                                        vertical:
                                                                            15),
                                                                    child: Text(
                                                                      'Edit task',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                              ),
                                                              ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        const WidgetStatePropertyAll(
                                                                            Appcolors.brandColor),
                                                                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10))),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            72,
                                                                        vertical:
                                                                            15),
                                                                    child: Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              17),
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xff006EE9)
                                                            .withOpacity(0.06),
                                                    width: 3,
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      miniTasks.values
                                                          .elementAt(index)
                                                          .name,
                                                      style: const TextStyle(
                                                          color: Appcolors
                                                              .textColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          miniTasks.remove(
                                                              miniTasks
                                                                  .keys
                                                                  .elementAt(
                                                                      index));
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Appcolors
                                                            .brandColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ));
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    content: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.32,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.84,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            TextField(
                                                              controller:
                                                                  miniTasknameContoller,
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          "Enter Task",
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Appcolors
                                                                                  .brandColor,
                                                                              width:
                                                                                  2),
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              12))),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Appcolors.brandColor),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Appcolors.brandColor),
                                                                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                                                              style: const TextStyle(
                                                                  color: Appcolors
                                                                      .subHeaderColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.02,
                                                            ),
                                                            ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      const WidgetStatePropertyAll(
                                                                          Appcolors
                                                                              .brandColor),
                                                                  shape: WidgetStatePropertyAll(
                                                                      RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10))),
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    miniTasks[
                                                                        (miniTasks.length +
                                                                                1)
                                                                            .toString()] = Minitask(
                                                                        name: miniTasknameContoller
                                                                            .text,
                                                                        id: (miniTasks.length +
                                                                                1)
                                                                            .toString(),
                                                                        status:
                                                                            false);
                                                                  });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  miniTasknameContoller
                                                                      .clear();
                                                                },
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          65,
                                                                      vertical:
                                                                          15),
                                                                  child: Text(
                                                                    'Add task',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                )),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.02,
                                                            ),
                                                            ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      const WidgetStatePropertyAll(
                                                                          Appcolors
                                                                              .brandColor),
                                                                  shape: WidgetStatePropertyAll(
                                                                      RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10))),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          72,
                                                                      vertical:
                                                                          15),
                                                                  child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            17),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Appcolors.brandColor
                                                          .withOpacity(0.9)),
                                              shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))))),
                                    ],
                                  )
                                ],
                              )),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all(Size(
                                      MediaQuery.of(context).size.width * 0.9,
                                      MediaQuery.of(context).size.height *
                                          0.06)),
                                  backgroundColor: WidgetStateProperty.all(
                                      Appcolors.brandColor.withOpacity(0.9)),
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)))),
                              onPressed: () {
                                if (endDate.difference(startDate).inDays < 0) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    backgroundColor: Appcolors.brandColor,
                                    content: Text(
                                      "End date can't be before start Date",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ));

                                  return;
                                }
                                if (selectedType == "Daily") {
                                  final res =
                                      Createnewdailyusecase(taksmanagementrepo)
                                          .call(Dailytask(
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              startDate: startDate,
                                              endDate: endDate,
                                              id: uuid.v4(),
                                              status: false));
                                  ref.invalidate(dailyTasksStateProvider);
                                  ref.refresh(dailyTasksStateProvider(ref));
                                  Navigator.of(context).pop();
                                } else if (selectedType == "Priority") {
                                  final res =
                                      Createnewpriorusecase(taksmanagementrepo)
                                          .call(Prioritytask(
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              startDate: startDate,
                                              endDate: endDate,
                                              id: uuid.v4(),
                                              status: false,
                                              miniTasksList: miniTasks,
                                              color: colors[random
                                                  .nextInt(colors.length)]));
                                  ref.invalidate(priorityTasksStateProvider);
                                  ref.refresh(priorityTasksStateProvider(ref));
                                  setState(() {
                                    miniTasks = {};
                                  });
                                  Navigator.of(context).pop();
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
              ),
            )
          ],
        ));
  }
}
