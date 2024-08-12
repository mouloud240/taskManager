import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager/core/connection/network_info.dart';
import 'package:task_manager/features/auth/data/source/local/local_user.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart'
    as TaskManagerUser;
part 'userState.g.dart';

@riverpod
class userState extends _$userState {
  @override
  Future<TaskManagerUser.User?> build() async {
    final networkInfo = NetworkInfoImpl(DataConnectionChecker());
    final local = LocalUser();
    if (await networkInfo.isConnected) {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (doc.data() != null) {
        final user = TaskManagerUser.User(
            password: doc.data()!["password"],
            email: doc.data()!["email"],
            username: doc.data()!["username"],
            uid: FirebaseAuth.instance.currentUser!.uid,
            userPfp: doc.data()!["userPfp"],
            profession: doc.data()!["profession"],
            dob: doc.data()!["dob"]
            
            );
        return user;
      } else {
        return TaskManagerUser.User(
            password: "password", email: "email", username: "username");
      }
    } else {
      final user = await local.getCurrentUser();
      return user.toEntity();
    }
  }
}
