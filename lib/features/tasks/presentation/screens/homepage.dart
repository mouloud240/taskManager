import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart'
    as taskManger;
import 'package:task_manager/features/auth/domain/usecases/logout.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';

DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final testPrioTask = Prioritytaskmodel(
      id: 0,
      icon: Icon(Icons.ac_unit),
      miniTasks: [
        Minitaskmodel(name: "making first Test", status: true,id: 0),
        Minitaskmodel(name: "making second Test", status: false,id: 1),
      ],
      title: "Testing function",
      description: "Trying to test the model",
      startDate: dateFormat.parse("July 27, 2024 at 1:06:24 AM"),
      endDate: dateFormat.parse("July 28, 2024 at 1:06:51 AM"));
  @override
  Widget build(BuildContext context) {
    final asyncVal = ref.watch(userStateProvider);
    final firetest = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    late taskManger.User? user;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            asyncVal.when(
              data: (data) {
                setState(() {
                  user = data;
                });
                ;
                return Text("${data!.username}");
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => CircularProgressIndicator(),
            ),
            ElevatedButton(
                onPressed: () {
                  LogoutUsecase(UserAuthRepositoryImplementation(
                          RemoteAuth(ref: ref)))
                      .call();

                  Navigator.of(context).pushNamed('login');
                },
                child: Text("Logout")),
            ElevatedButton(
                onPressed: () {
                  db
                      .collection("users")
                      .doc(user!.uid)
                      .update({"testPriorMiniGen": FieldValue.delete()});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Deleted data")));
                },
                child: Text("ClickMe"))
          ],
        ),
      ),
    );
  }
}
