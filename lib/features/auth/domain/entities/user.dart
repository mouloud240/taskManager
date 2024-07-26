import 'dart:io';

import 'package:flutter/material.dart';

class User {
  String? username;
  String? uid;
  File? userPfp;
  String password;
  String email;
  User({this.username, this.uid, required this.password, required this.email});
  Map<String, dynamic> userTojson() {
    return {
      "username": username,
      "uid": uid,
      "password": password,
      "email": email,
    };
  }
}
