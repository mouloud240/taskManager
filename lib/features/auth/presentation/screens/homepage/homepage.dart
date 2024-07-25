import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/usecases/logout.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Text(
            "Homepage",
          ),
          ElevatedButton(
              onPressed: () {
                LogoutUsecase(UserAuthRepositoryImplementation(RemoteAuth()))
                    .call();
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}
