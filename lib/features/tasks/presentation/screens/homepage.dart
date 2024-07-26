import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart'
    as taskManger;
import 'package:task_manager/features/auth/domain/usecases/logout.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
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

                return Text("${data!.uid}");
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => CircularProgressIndicator(),
            ),
            ElevatedButton(
                onPressed: () {
                  LogoutUsecase(UserAuthRepositoryImplementation(RemoteAuth()))
                      .call();

                  Navigator.of(context).pushNamed('login');
                },
                child: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
