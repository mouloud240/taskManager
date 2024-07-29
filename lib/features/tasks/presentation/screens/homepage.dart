import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
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
  final pages = [const Home(), const Calendar(), const Profile()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          DateFormat.yMMMEd().format(DateTime.now()),
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Appcolors.subHeaderColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              print("Notification clicked");
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                'lib/core/assets/icons/notification.svg',
                width: 22,
                height: 22,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            // ignore: unused_result
            ref.refresh(userStateProvider);
            // ignore: unused_result
            ref.refresh(DailyTasksStateProvider(ref));
            return ref.refresh(priorityTasksStateProvider(ref));
          },
          child: ListView(children: [pages[index]])),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "lib/core/assets/icons/homePassive.svg",
                ),
                activeIcon: SvgPicture.asset(
                  "lib/core/assets/icons/homeActive.svg",
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "lib/core/assets/icons/calendarPassive.svg",
                ),
                activeIcon: SvgPicture.asset(
                    "lib/core/assets/icons/calendarActive.svg"),
                label: 'Calendar'),
            BottomNavigationBarItem(
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
