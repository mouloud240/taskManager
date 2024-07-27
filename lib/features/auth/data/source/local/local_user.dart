import 'package:hive/hive.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

class LocalUser {
  final userBox = Hive.box("User");
  Future<void> storeCurrentUser(UserModel user) async {
    await userBox.put('current_user', user);
  }

  Future<UserModel> getCurrentUser() async {
    return userBox.get('current_user');
  }

  Future<void> removeCurrentUser() async {
    await userBox.delete('current_user');
  }
}
