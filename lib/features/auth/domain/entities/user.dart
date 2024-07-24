import 'dart:io';

import 'package:flutter/material.dart';

class User {
  String username;
  int uid;
  File? userPfp;
  String password;
  String email;
  User({required this.username, required this.uid, required this.password,required this.email});
}
