import 'dart:ffi';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/data/source/local/local_user.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart' as u;

class RemoteAuth {
  final fireauth = FirebaseAuth.instance;
  Future<Either<Failure, bool>> login(String email, String password) async {
    try {
      await fireauth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

      return const Right(Void);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(errMessage: e.code));
    }
  }

  Future<Either<Failure, void>> changePassword(String password) async {
    try {
      fireauth.currentUser?.updatePassword(password);
      return right(Void);
    } on FirebaseAuthException catch (e) {
      return left(Failure(errMessage: e.code));
    }
  }

  Future<Either<Failure, UserCredential>> signup(u.User user) async {
    try {
      return right(await fireauth.createUserWithEmailAndPassword(
          email: user.email, password: user.password));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(errMessage: e.code));
    }
  }
  Future<Either<Failure,void>>resetPassword(String email)async{
    try{
      await fireauth.sendPasswordResetEmail(email: email);
      return right(Void);
    }on FirebaseAuthException catch(e){
      return left(Failure(errMessage: e.code));
    }
  }
}
