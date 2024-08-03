import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';
import 'package:task_manager/features/auth/domain/usecases/signup.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final db = FirebaseFirestore.instance;

  final Color blueColor = const Color(0xFF007BFF);
  RegExp passRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  RegExp mailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    final userauthImpl = UserAuthRepositoryImplementation(RemoteAuth(ref: ref));
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: SvgPicture.asset("lib/core/assets/icons/backArrow.svg"),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "TASK-WAN",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                    fontSize: 35),
              ),
              const Text(
                "Management  App",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Text(
                "Create an account",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const Spacer(),
              textField(
                  formValidator: (value) {
                    if (value!.isEmpty) {
                      return "Field Required";
                    } else {
                      return null;
                    }
                  },
                  blueColor: blueColor,
                  hintText: "Username",
                  icon: Icons.person,
                  controller: usernameController),
              textField(
                  formValidator: (value) {
                    if (value!.isEmpty) {
                      return "Field Required";
                    } else if (!mailRegex.hasMatch(value)) {
                      return "Invalid Email";
                    } else {
                      return null;
                    }
                  },
                  blueColor: blueColor,
                  hintText: "email",
                  icon: Icons.email,
                  controller: emailController),
              textField(
                formValidator: (value) {
                  if (value!.isEmpty) {
                    return "Field Required";
                  } else if (!passRegex.hasMatch(value)) {
                    return "Password must contain at least 8 characters, one uppercase, one lowercase, one number and one special character";
                  } else {
                    return null;
                  }
                },
                hideText: passwordVisible,
                blueColor: blueColor,
                hintText: "Password",
                icon: Icons.lock,
                controller: passwordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: blueColor,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              textField(
                formValidator: (value) {
                  if (value!.isEmpty) {
                    return "Field Required";
                  } else if (value != passwordController.text) {
                    return "Passwords do not match";
                  } else {
                    return null;
                  }
                },
                blueColor: blueColor,
                hintText: "Confirm Password",
                hideText: passwordVisible,
                icon: Icons.lock,
                controller: passwordConfirmController,
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: blueColor,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.075,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.blue)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dartz.Either<Failure, auth.UserCredential> result =
                            await Signup(userauthImpl).call(UserModel(
                                username: usernameController.text,
                                password: passwordController.text,
                                email: emailController.text));
                        result.fold((failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                failure.errMessage,
                              ),
                            ),
                          );
                        }, (usercred) {
                          db.collection("users").doc(usercred.user!.uid).set({
                            "username": usernameController.text,
                            "email": emailController.text,
                            "password": passwordController.text,
                            "priorityTasks": {},
                            "dailyTasks": {}
                          });

                          // LoginUsecase(userauthImpl).call(emailController.text, passwordController.text);
                          Navigator.of(context).pushNamed("home");
                        });
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class textField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool hideText;
  final IconButton? suffixIcon;
  final String? Function(String?)? formValidator;
  const textField({
    super.key,
    required this.formValidator,
    required this.blueColor,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.suffixIcon,
    this.hideText = false,
  });

  final Color blueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: TextFormField(
          keyboardType: (hintText == "email")
              ? TextInputType.emailAddress
              : TextInputType.text,
          validator: formValidator,
          obscureText: hideText,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              suffixIcon: suffixIcon,
              prefixIcon: Container(
                height: MediaQuery.of(context).size.height * 0.065,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blueColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blueColor, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ) // Adjust this to add space
              ),
        ),
      ),
    );
  }
}
