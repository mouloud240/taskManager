import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/colors.dart';

class CalendarpageAppbar extends ConsumerStatefulWidget {
  const CalendarpageAppbar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalendarpageAppbarState();
}

DateTime currentDate = DateTime.now();

class _CalendarpageAppbarState extends ConsumerState<CalendarpageAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      leadingWidth: MediaQuery.of(context).size.width * 0.4,
      toolbarHeight: 140,
      leading: Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: Row(
          children: [
            SvgPicture.asset(
              "lib/core/assets/icons/calendarActive.svg",
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              DateFormat.yMMM().format(currentDate),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.04, top: 5),
          child: GestureDetector(
            onTap: () async {
              Navigator.of(context).pushNamed('create');
            },
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 64, 136, 171),
                        blurRadius: 3,
                        spreadRadius: 0,
                        blurStyle: BlurStyle.outer)
                  ],
                  color: Appcolors.brandColor,
                  borderRadius: BorderRadius.circular(10)),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    "Add Task",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
