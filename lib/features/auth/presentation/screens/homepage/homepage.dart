import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/usecases/logout.dart';

class Homepage extends ConsumerWidget {
  Homepage({super.key});
  final FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Text(
            "${fireAuth.currentUser != null ? fireAuth.currentUser?.uid : "error"}",
          ),
          ElevatedButton(
              onPressed: () {
                LogoutUsecase(UserAuthRepositoryImplementation(RemoteAuth()))
                    .call();
                Navigator.of(context).pushNamed('login');
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}
