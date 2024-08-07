import 'package:flutter/material.dart';
import 'package:task_manager/core/colors.dart';

class ProfilepageAppbar extends StatefulWidget {
  const ProfilepageAppbar({super.key});

  @override
  State<ProfilepageAppbar> createState() => _ProfilepageAppbarState();
}

class _ProfilepageAppbarState extends State<ProfilepageAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.15),
          child: const Text(
            "Profile",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Appcolors.brandColor,
      toolbarHeight: MediaQuery.of(context).size.height * 0.15,
    );
  }
}
