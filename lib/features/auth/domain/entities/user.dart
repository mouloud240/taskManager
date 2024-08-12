import 'dart:io';

import 'package:flutter/material.dart';

class User {
  String? username;
  String? uid;
  String? userPfp;
  String? profession;
  DateTime? dob;
  String password;
  String email;
  User(
      {this.username,
      this.uid,
      this.dob,
      this.profession,
      required this.password,
      required this.email,
      this.userPfp});
  Map<String, dynamic> userTojson() {
    return {
      "username": username,
      "uid": uid,
      "password": password,
      "email": email,
      "userPfp": userPfp,
      "dob": dob,
      "profession": profession
    };
  }
}
