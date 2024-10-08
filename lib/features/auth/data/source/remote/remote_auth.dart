import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/data/source/local/local_user.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';

DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");

class RemoteAuth {
  WidgetRef ref;

  RemoteAuth({required this.ref});

  final local = LocalUser();
  final fireauth = FirebaseAuth.instance;
  UserModel getUserState() {
    return ref.watch(userStateProvider).when(
          data: (data) => UserModel.fromEntity(data!),
          error: (erro, stk) => throw Exception(),
          loading: () => UserModel(email: "", password: ""),
        );
  }

  Future<Either<Failure, bool>> login(String email, String password) async {
    try {
      UserModel user = UserModel(email: email, password: password);
      await fireauth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (doc.data() != null) {
        user = UserModel(
            password: doc.data()!["password"],
            email: doc.data()!["email"],
            username: doc.data()!["username"],
            uid: FirebaseAuth.instance.currentUser!.uid);
      }
      local.storeCurrentUser(user);

      return const Right(true); // Login successful
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors here
      return Left(
          Failure(errMessage: e.code.toString())); // Return error message
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await fireauth.signOut();
      local.removeCurrentUser();
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(errMessage: e.code));
    }
  }

  Future<Either<Failure, void>> changePassword(String password) async {
    try {
      fireauth.currentUser?.updatePassword(password);
      ref.refresh(userStateProvider);
      local.storeCurrentUser(getUserState());

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(Failure(errMessage: e.code));
    }
  }

  Future<Either<Failure, UserCredential>> signup(UserModel user) async {
    try {
      local.storeCurrentUser(user);
      return right(await fireauth.createUserWithEmailAndPassword(
          email: user.email, password: user.password));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(errMessage: e.code));
    }
  }

  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await fireauth.sendPasswordResetEmail(email: email);
      return right(Unit);
    } on FirebaseAuthException catch (e) {
      return left(Failure(errMessage: e.code));
    }
  }

  Future<Either<Failure, void>> updateUserpfp(String newUrl) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"userPfp": newUrl});
      return right(Unit);
    } catch (e) {
      return left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> updatecreds(
      String proffesion, String name, DateTime dob) async {
    late UserModel user;
    try {
      final doc = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      doc.update({
        "proffesion": proffesion,
        "username": name,
        "dob": "${dateFormat.format(dob)} UTC+1"
      });
      ref.invalidate(userStateProvider);
      return right(Unit);
    } catch (e) {
      return left(Failure(errMessage: e.toString()));
    }
  }
}
