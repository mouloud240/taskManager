import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/presentation/screens/PriorityTaskView.dart';

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

class PriorityTasktile extends StatelessWidget {
  final Prioritytask prioritytask;
  const PriorityTasktile({super.key, required this.prioritytask});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Prioritytaskview(
                  model: prioritytask,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.24,
            width: MediaQuery.of(context).size.width * 0.344,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 99, 96, 96),
                    blurRadius: 3,
                    spreadRadius: 0,
                    blurStyle: BlurStyle.outer)
              ],
              color: prioritytask.color,
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage('lib/core/assets/images/bg.png'),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "${prioritytask.getRemainingTime().toString()} days",
                          style: const TextStyle(
                              color: Appcolors.headerColor, fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      prioritytask.icon == null
                          ? SvgPicture.asset(
                              'lib/core/assets/icons/default.svg',
                              width: 20,
                              height: 20,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: prioritytask.icon,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          prioritytask.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8  ),
                        child: Text(
                          "Progress",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    ProgressBar(
                      prioritytask: prioritytask,
                      width: MediaQuery.of(context).size.width * 0.344,
                      background: Colors.grey[700] as Color,
                      foreground: Colors.white,
                      displayprogress: false,
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "${prioritytask.calculateprogress()}%",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.prioritytask,
    required this.width,
    required this.foreground,
    required this.background,
    required this.displayprogress,
    required this.height,
  });

  final double width;
  final Color foreground;
  final Color background;
  final bool displayprogress;
  final double height;
  final Prioritytask prioritytask;

  @override
  Widget build(BuildContext context) {
    double progress = prioritytask.calculateprogress().toDouble();
    double progressWidth = (width * progress) / 100;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Container(
                  width: progressWidth,
                  decoration: BoxDecoration(
                    color: foreground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                if (displayprogress)
                  Center(
                    child: Text(
                      "${progress.toInt().toString()}%",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
