import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/presentation/state/calendarstartDate.dart';

class CalendarpageAppbar extends ConsumerStatefulWidget {
  const CalendarpageAppbar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalendarpageAppbarState();
}

class _CalendarpageAppbarState extends ConsumerState<CalendarpageAppbar> {
  DateTime startDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final asyncVal = ref.watch(calendarStartdateProvider);
    @override
    initState() {
      super.initState();
      startDate = asyncVal;
    }

    return SliverAppBar(
      pinned: false,
      leadingWidth: MediaQuery.of(context).size.width * 0.4,
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      leading: Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          backgroundColor: Colors.white,
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.84,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TableCalendar(
                                  selectedDayPredicate: (day) {
                                    return isSameDay(startDate, day);
                                  },
                                  calendarStyle: const CalendarStyle(
                                      todayDecoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          shape: BoxShape.circle),
                                      selectedDecoration: BoxDecoration(
                                        color: Appcolors.brandColor,
                                        shape: BoxShape.circle,
                                      )),
                                  daysOfWeekStyle: const DaysOfWeekStyle(
                                      weekdayStyle: TextStyle(
                                          color: Appcolors.textColor,
                                          fontWeight: FontWeight.w500),
                                      weekendStyle: TextStyle(
                                          color: Appcolors.brandColor,
                                          fontWeight: FontWeight.w500)),
                                  weekendDays: const [
                                    DateTime.friday,
                                    DateTime.saturday
                                  ],
                                  headerStyle: const HeaderStyle(
                                      leftChevronIcon: Icon(
                                        Icons.arrow_left_sharp,
                                        color: Appcolors.brandColor,
                                        size: 40,
                                      ),
                                      rightChevronIcon: Icon(
                                        Icons.arrow_right_sharp,
                                        color: Appcolors.brandColor,
                                        size: 40,
                                      ),
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                      titleTextStyle: TextStyle(
                                          color: Appcolors.brandColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  focusedDay: startDate,
                                  firstDay: DateTime.utc(2010, 01, 01),
                                  lastDay: DateTime.utc(2030, 12, 12),
                                  onDaySelected: (selectedDay, focusDay) {
                                    setState(() {
                                      ref
                                          .read(calendarStartdateProvider
                                              .notifier)
                                          .changeDate(selectedDay);
                                      startDate = selectedDay;
                                      focusDay = selectedDay;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ));
                    });
              },
              child: SvgPicture.asset(
                "lib/core/assets/icons/calendarActive.svg",
                width: 25,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              DateFormat.yMMM().format(startDate),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.04, top: 5),
          child: GestureDetector(
            onTap: () async {
              Navigator.of(context).pushNamed('create');
            },
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 64, 136, 171),
                        blurRadius: 3,
                        spreadRadius: 0,
                        blurStyle: BlurStyle.outer)
                  ],
                  color: Appcolors.brandColor,
                  borderRadius: BorderRadius.circular(10)),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    "Add Task",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
