import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final UserValue = ref.watch(userStateProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserValue.when(
              data: (data) {
                String getFirstWord(String? input) {
                  List<String> words = input!.split(' ');
                  return words.isNotEmpty ? words[0] : '';
                }

                String name = getFirstWord(data!.username);
                return Text(
                  "Welocme $name",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Appcolors.headerColor,
                    fontSize: 25,
                  ),
                );
              },
              error: (error, stackTrace) => const Text("Error"),
              loading: () => const CircularProgressIndicator()),
          const Text(
            "Have a nice day!",
            style: TextStyle(
                color: Appcolors.subHeaderColor,
                fontSize: 18,
                fontWeight: FontWeight.normal),
          ),
          const Text(
            "My Priority Tasks",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          const Text(
            "My Daily Tasks",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
