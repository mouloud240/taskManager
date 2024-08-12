import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profilelisttile extends ConsumerWidget {
  String name;
  String Icon;
  void Function()? onTap;
  Profilelisttile(
      {super.key, required this.name, required this.Icon, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Icon,
                width: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.065,
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }
}
