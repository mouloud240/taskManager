import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/colors.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/usecases/logout.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/presentation/widgets/profileListTile.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final userAuthRepo = UserAuthRepositoryImplementation(RemoteAuth(ref: ref));
    final user = ref.watch(userStateProvider);
    final profilepages = [
      {
        "name": "My profile",
        "icon": "lib/core/assets/icons/profile.svg",
        "onclick": () {
          Navigator.of(context).pushNamed('editProfile');
        }
      },
      {
        "name": "Statistic",
        "icon": "lib/core/assets/icons/stats.svg",
        "onclick": () {
          Navigator.of(context).pushNamed('soon');
        }
      },
      {
        "name": "location",
        "icon": "lib/core/assets/icons/location.svg",
        "onclick": () {
          Navigator.of(context).pushNamed('soon');
        }
      },
      {
        "name": "Settings",
        "icon": "lib/core/assets/icons/settings.svg",
        "onclick": () {
          Navigator.of(context).pushNamed('soon');
        }
      },
      {
        "name": "logout",
        "icon": "lib/core/assets/icons/logout.svg",
        "onclick": () async {
          final res = await LogoutUsecase(userAuthRepo).call();
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
        }
      }
    ];
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          user.when(
            data: (currUser) {
              return Container(
                margin: const EdgeInsets.all(12),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Appcolors.brandColor.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 50,
                      backgroundImage: currUser!.userPfp == null
                          ? const AssetImage(
                              'lib/core/assets/images/default_profile.png')
                          : NetworkImage(currUser.userPfp!),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      currUser.username ?? '',
                      style: const TextStyle(
                          color: Appcolors.brandColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      currUser.profession ?? "cool guy",
                      style: const TextStyle(
                          color: Appcolors.subHeaderColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
            error: (err, stackTree) => Text(err.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Profilelisttile(
                    name: profilepages[index]['name'] as String,
                    Icon: profilepages[index]['icon'] as String,
                    onTap: profilepages[index]['onclick'] as Function());
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
              itemCount: profilepages.length),
        ],
      ),
    );
  }
}
