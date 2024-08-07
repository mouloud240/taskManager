import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/presentation/screens/CreatenewTask.dart';
import 'package:task_manager/features/tasks/presentation/screens/tabsScreen/PriorityTasks.dart';
import 'package:task_manager/features/tasks/presentation/screens/tabsScreen/dailyTasks.dart';
import 'package:task_manager/features/tasks/presentation/state/calendarstartDate.dart';

final _weekdays = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarState();
}

List<DateTime> getDaysOfCurrentMonth(DateTime buildDate) {
  // Get the current date
  DateTime now = buildDate;

  // Determine the first day of the current month
  DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);

  // Determine the last day of the current month
  DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

  // Generate a list of days in the current month
  List<DateTime> daysOfMonth = [];
  for (int day = 1; day <= lastDayOfMonth.day; day++) {
    daysOfMonth.add(DateTime(now.year, now.month, day));
  }

  return daysOfMonth;
}

class _CalendarState extends ConsumerState<Calendar>
    with TickerProviderStateMixin {
  final _tabs = [const PrioritytasksTab(), const DailytasksTab()];
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TabController _tabController;
  @override
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _animationController.reset();
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    DateTime buildDate = ref.watch(calendarStartdateProvider);
    final days = getDaysOfCurrentMonth(buildDate);
    return Column(
      children: [
        Visibility(
          visible: ref.watch(filterStateProvider),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      const WidgetStatePropertyAll(Appcolors.brandColor),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: () {
                ref.read(filterStateProvider.notifier).changeFilter(false);
                ref
                    .read(calendarStartdateProvider.notifier)
                    .changeDate(DateTime.utc(2000));
              },
              child: const Text(
                'Show All',
                style: TextStyle(color: Colors.white),
              )),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (days[index].compareTo(buildDate) == 0) {
                  return GestureDetector(
                    onTap: () {
                      if (days[index].compareTo(startDate) == 0) {
                        ref
                            .read(filterStateProvider.notifier)
                            .changeFilter(false);
                      } else {
                        ref
                            .read(filterStateProvider.notifier)
                            .changeFilter(true);
                      }
                      ref
                          .read(calendarStartdateProvider.notifier)
                          .changeDate(days[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 60,
                      decoration: const BoxDecoration(
                          color: Appcolors.brandColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _weekdays[days[index].weekday],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            days[index].day.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ],
                      )),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    if (days[index].compareTo(startDate) == 0) {
                      ref
                          .read(filterStateProvider.notifier)
                          .changeFilter(false);
                    } else {
                      ref.read(filterStateProvider.notifier).changeFilter(true);
                    }
                    ref
                        .read(calendarStartdateProvider.notifier)
                        .changeDate(days[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Color(0xffEBF2FF),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _weekdays[days[index].weekday],
                            style: const TextStyle(
                                color: Appcolors.brandColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            days[index].day.toString(),
                            style: const TextStyle(
                                color: Appcolors.brandColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ],
                      )),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 5,
                  ),
              itemCount: days.length),
        ),
        TabBar(
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            dividerColor: Colors.transparent,
            indicatorPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08),
            indicatorColor: Appcolors.brandColor,
            labelStyle: const TextStyle(
                color: Appcolors.brandColor,
                fontFamily: "Sofia pro",
                fontSize: 17,
                fontWeight: FontWeight.w700),
            tabs: const [
              Tab(
                text: "Priority Task",
              ),
              Tab(
                text: "Daily Task",
              ),
            ]),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return SizedBox(
              //todo Fix this
              height: double.maxFinite,
              child: FadeTransition(
                opacity: _animation,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child:
                      TabBarView(controller: _tabController, children: _tabs),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
