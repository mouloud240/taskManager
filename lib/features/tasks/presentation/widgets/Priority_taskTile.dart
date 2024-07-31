import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';

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
    return Container(
        height: MediaQuery.of(context).size.height * 0.23,
        width: MediaQuery.of(context).size.width * 0.344,
        decoration: BoxDecoration(
          color: prioritytask.color,
          borderRadius: BorderRadius.circular(10),
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
            ProgressBar(prioritytask: prioritytask),
          ],
        ));
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.prioritytask,
  });

  final Prioritytask prioritytask;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Progress",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(10),
              ),
              height: 10,
              width: MediaQuery.of(context).size.width * 0.344,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 10,
                    width: MediaQuery.of(context).size.width *
                        0.344 *
                        (prioritytask.calculateprogress() / 100),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                "${prioritytask.calculateprogress()}%",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
