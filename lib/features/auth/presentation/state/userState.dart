import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart'
    as TaskManagerUser;
part 'userState.g.dart';

@riverpod
class userState extends _$userState {
  @override
  Future<TaskManagerUser.User?> build() async {
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
        uid: FirebaseAuth.instance.currentUser!.uid
      );
     
      return user;
    } else {
      return TaskManagerUser.User(
          password: "password", email: "email", username: "username");
    }
  }
}