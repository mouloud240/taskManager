import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class welcomePages {
  static final firstpage = PageViewModel(
      title: "Easy Time Management",
      body:
          "With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first ",
      image: SvgPicture.asset("lib/core/assets/images/get_started1.svg"));
  static final secondpage = PageViewModel(
      title: "Increase Work Effectiveness",
      body:
          "Time management and the determination of more important tasks will give your job statistics better and always improve",
      image: SvgPicture.asset("lib/core/assets/images/get_started2.svg"));
  static final thirdpage = PageViewModel(
      title: "Reminder Notification",
      body:
          "The advantage of this application is that it also provides reminders for you so you don't forget to keep doing your assignments well and according to the time you have set",
      image: SvgPicture.asset("lib/core/assets/images/get_started3.svg"));
}
