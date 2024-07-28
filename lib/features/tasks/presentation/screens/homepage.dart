import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart'
    as taskManger;
import 'package:task_manager/features/auth/domain/usecases/logout.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';

DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final testPrioTask2 = Prioritytaskmodel(
      id: "1",
      icon: const Icon(Icons.ac_unit),
      miniTasks: {
        "0": Minitaskmodel(name: "making first Test", status: true, id: "0"),
        "1": Minitaskmodel(name: "making second Test", status: false, id: "1"),
      },
      title: "booty",
      description: "Homelander done killed me wife and took me bloody son",
      startDate: dateFormat.parse("July 27, 2024 at 1:06:24 AM"),
      endDate: dateFormat.parse("July 28, 2024 at 1:06:51 AM"));
  final testPrioTask3 = Prioritytaskmodel(
      id: "0",
      icon: const Icon(Icons.ac_unit),
      miniTasks: {
        "0": Minitaskmodel(name: "making first Test", status: true, id: "0"),
        "1": Minitaskmodel(name: "making second Test", status: false, id: "1"),
      },
      title: "Simouh",
      description: "permutation",
      startDate: dateFormat.parse("July 27, 2024 at 1:06:24 AM"),
      endDate: dateFormat.parse("July 28, 2024 at 1:06:51 AM"));
  @override
  Widget build(BuildContext context) {
    final remote = RemoteDataSource(ref);

    final asyncVal = ref.watch(userStateProvider);
    final firetest = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    late taskManger.User? user;

    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () async {
              ref.refresh(userStateProvider);
            },
            child: ListView(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      asyncVal.when(
                        data: (data) {
                          setState(() {
                            user = data;
                          });
                          return Text("${data!.username}");
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const CircularProgressIndicator(),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            LogoutUsecase(UserAuthRepositoryImplementation(
                                    RemoteAuth(ref: ref)))
                                .call();

                            Navigator.of(context).pushNamed('login');
                          },
                          child: const Text("Logout")),
                      ElevatedButton(
                          onPressed: () async {
                            Either<Failure, void> result =
                                await remote.addNewtaskInPriorityTask_remote(
                                    testPrioTask2,
                                    Minitaskmodel(
                                        name: "Done killed me", id: "0"));

                            result.fold(
                                (l) => ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                        SnackBar(content: Text(l.errMessage))),
                                (r) => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text("Task Deleted"))));
                          },
                          child: const Text("ClickMe"))
                    ],
                  ),
                ),
              ],
            )));
  }
}
