import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/usecases/logout.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              final res = await LogoutUsecase(
                      UserAuthRepositoryImplementation(RemoteAuth(ref: ref)))
                  .call();

              res.fold((fail) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    fail.errMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Appcolors.brandColor,
                ));
              }, (_) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "login", (route) => false);
              });
            },
            child: const Icon(
              Icons.logout,
              color: Appcolors.brandColor,
            )),
        Container(
          child: const Text("Profile"),
        ),
      ],
    );
  }
}
