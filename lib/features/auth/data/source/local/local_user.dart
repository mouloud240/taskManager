import 'package:hive/hive.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

class LocalUser {
  late final Box userBox;
  Future<void> storeCurrentUser(User user) async {
    await userBox.put('current_user', user);
  }

  Future<User> getCurrentUser() async {
    return userBox.get('current_user');
  }
  Future<void> removeCurrentUser() async {
    await userBox.delete('current_user');
  }
}
