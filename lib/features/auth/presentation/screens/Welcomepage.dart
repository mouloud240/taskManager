import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:task_manager/features/auth/presentation/screens/introductionScreens/get_started.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      dotsDecorator:
          DotsDecorator(color: Colors.grey, activeColor: Colors.blue),
      bodyPadding: EdgeInsets.only(top: 80),
      pages: [
        welcomePages.firstpage,
        welcomePages.secondpage,
        welcomePages.thirdpage
      ],
      done: Text(
        "Done",
        style: TextStyle(color: Colors.blue),
      ),
      showNextButton: false,
      showSkipButton: true,
      skip: const Text(
        "Skip",
        style: TextStyle(color: Colors.blue),
      ),
      onDone: () {
        Navigator.of(context).pushNamed("login");
      },
    );
  }
}
