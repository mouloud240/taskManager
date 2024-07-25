import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/data/source/local/local_user.dart';

class RemoteAuth {
  final fireauth = FirebaseAuth.instance;
  Future<bool> login(String email, String password) async {
    await fireauth.signInWithEmailAndPassword(email: email, password: password);
    return true;
  }

  Future<void> logout() async {
    fireauth.signOut();
  }

  Future<void> changePassword(String password) async {
    fireauth.currentUser?.updatePassword(password);
  }

  Future<void> signup(UserModel user) async {
    fireauth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }
}
