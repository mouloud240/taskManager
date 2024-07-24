import 'package:fireauth/fireauth.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/data/source/local/local_user.dart';

class RemoteAuth {
  UserModel user;
  LocalUser localUser = LocalUser();
  RemoteAuth(this.user);
  final fireauth = FirebaseAuth.instance;
  Future<void> login(UserModel user) async {
    fireauth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
    localUser.storeCurrentUser(user);
  }

  Future<void> logout() async {
    fireauth.signOut();
    localUser.removeCurrentUser();
  }

  Future<void> changePassword(String password) async {
    fireauth.currentUser?.updatePassword(password);
  }

  Future<void> signup(UserModel user) async {
    fireauth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }
}
