import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/createNewPriorUsecase.dart';
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

  final Prioritytask prioritytask = Prioritytask(
      miniTasksList: {},
      title: "Drawing Test",
      description: "I am here",
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      id: "25",
      status: false);
  final Prioritytask prioritytask2 = Prioritytask(
      miniTasksList: {},
      title: "TEst 2 ",
      description: "I'm still standing",
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      id: "12",
      status: false);
  final pages = [const Home(), const Calendar(), const Profile()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    TaskmanagementRepositoryImplementation taskmanag =
        TaskmanagementRepositoryImplementation(
      localDataSource: LocalDataSource(),
      remoteDataSource: RemoteDataSource(ref),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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
              Createnewpriorusecase(taskmanag).call(prioritytask2);
              print("Notification clickedd");
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
            return ref.refresh(userStateProvider);
          },
          child: pages[index]),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          fixedColor: Colors.white,
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
