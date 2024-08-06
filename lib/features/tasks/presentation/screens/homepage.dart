import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_spacing/responsive_spacing.dart';
import 'package:task_manager/core/colors.dart';

import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/presentation/screens/appbars/calendarPage_appbar.dart';

import 'package:task_manager/features/tasks/presentation/screens/appbars/homepage_appBar.dart';
import 'package:task_manager/features/tasks/presentation/screens/bottomAppbarpages/calendar.dart';
import 'package:task_manager/features/tasks/presentation/screens/bottomAppbarpages/home.dart';
import 'package:task_manager/features/tasks/presentation/screens/bottomAppbarpages/profile.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';

DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  final pages = [const Home(), const Calendar(), const Profile()];
  final appbars = [
    const homePage_appbar(),
    const CalendarpageAppbar(),
    const homePage_appbar()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    TaskmanagementRepositoryImplementation taskmanag =
        TaskmanagementRepositoryImplementation(
      localDataSource: LocalDataSource(),
      remoteDataSource: RemoteDataSource(ref),
    );
    return ResponsiveScaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(dailyTasksStateProvider);
            ref.invalidate(priorityTasksStateProvider);
            return await ref.refresh(priorityTasksStateProvider(ref).future);
          },
          child: CustomScrollView(
            slivers: [
              appbars[index],
              SliverToBoxAdapter(
                child: pages[index],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: SvgPicture.asset(
                  "lib/core/assets/icons/homePassive.svg",
                ),
                activeIcon: SvgPicture.asset(
                  "lib/core/assets/icons/homeActive.svg",
                ),
                label: "Home"),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: SvgPicture.asset(
                  "lib/core/assets/icons/calendarPassive.svg",
                ),
                activeIcon: SvgPicture.asset(
                    "lib/core/assets/icons/calendarActive.svg"),
                label: 'Calendar'),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: SvgPicture.asset(
                  "lib/core/assets/icons/profilePassive.svg",
                ),
                activeIcon: SvgPicture.asset(
                  "lib/core/assets/icons/profileActive.svg",
                ),
                label: 'Profile'),
          ],
          currentIndex: index,
          onTap: (int index) {
            setState(() {
              this.index = index;
            });
          }),
    );
  }
}
