import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/presentation/screens/tabsScreen/PriorityTasks.dart';
import 'package:task_manager/features/tasks/presentation/screens/tabsScreen/dailyTasks.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarState();
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
    return Column(
      children: [
        Column(
          children: [
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
                return FadeTransition(
                  opacity: _animation,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child:
                        TabBarView(controller: _tabController, children: _tabs),
                  ),
                );
              },
            )
          ],
        )
      ],
    );
  }
}
