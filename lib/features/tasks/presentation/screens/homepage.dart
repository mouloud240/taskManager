import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart'
    as taskManger;
import 'package:task_manager/features/auth/domain/usecases/logout.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
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
      appBar: AppBar(
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
            ref.refresh(userStateProvider);
            ref.refresh(DailyTasksStateProvider(ref));
            ref.refresh(priorityTasksStateProvider(ref));
          },
          child: ListView(children: [pages[index]])),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
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
