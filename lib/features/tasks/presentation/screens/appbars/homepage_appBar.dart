import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/colors.dart';

class homePage_appbar extends StatelessWidget {
  const homePage_appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      scrolledUnderElevation: 0,
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
    );
  }
}
