import 'package:flutter/material.dart';
import 'package:task_manager/core/colors.dart';

class Comingsoon extends StatelessWidget {
  const Comingsoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: const Text(
          "Coming Soon",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Appcolors.brandColor,
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Appcolors.brandColor),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
          ),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Appcolors.brandColor),
        ),
      ),
    );
  }
}
