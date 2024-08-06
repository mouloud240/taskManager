import 'package:flutter/material.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';

class Dailytaskbigtile extends StatelessWidget {
  final Dailytask dailytask;
  const Dailytaskbigtile({super.key, required this.dailytask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              bottom:
                  BorderSide(color: const Color(0xffABCEF5).withOpacity(0.5)),
              right:
                  BorderSide(color: const Color(0xffABCEF5).withOpacity(0.5)),
              left: BorderSide(color: const Color(0xffABCEF5).withOpacity(0.5)),
              top: BorderSide(color: const Color(0xffABCEF5).withOpacity(0.5)),
            ),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Text(
            dailytask.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
          )),
    );
  }
}
