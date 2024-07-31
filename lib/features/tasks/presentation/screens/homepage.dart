import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';
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

  final pages = [const Home(), const Calendar(), const Profile()];
  int index = 0;
  Prioritytaskmodel test2 = Prioritytaskmodel(
    id: "0",
    miniTasks: {
      "0": Minitaskmodel(name: "making first Test", status: true, id: "0"),
      "1": Minitaskmodel(name: "making second Test", status: false, id: "1"),
    },
    title: "Testing function",
    description: "Trying to test the model",
    startDate: dateFormat.parse("July 27, 2024 at 1:06:24 AM"),
    endDate: dateFormat.parse("July 28, 2024 at 1:06:51 AM"),
    status: false,
    color: const Color(0xff362075),
  );
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
            onTap: () async {
              final res = await Createnewpriorusecase(taskmanag).call(test2);
              res.fold((l) => print(l.errMessage), (r) => print("Task added"));
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
            ref.refresh(userStateProvider.notifier);
            ref.invalidate(dailyTasksStateProvider);
            ref.invalidate(priorityTasksStateProvider);
            await ref.refresh(dailyTasksStateProvider(ref).future);
            return await ref.refresh(priorityTasksStateProvider(ref).future);
          },
          child: ListView(children: [pages[index]])),
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
