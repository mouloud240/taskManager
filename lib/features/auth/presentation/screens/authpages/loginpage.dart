import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as prefix;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_spacing/responsive_spacing.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/usecases/login.dart';
import 'package:task_manager/features/auth/presentation/screens/authpages/forgotPassword.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final RegExp passRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  final RegExp mailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool passwordVisible = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final userAuthRepo = UserAuthRepositoryImplementation(RemoteAuth(ref: ref));
    return ResponsiveScaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 3,
              ),
              const Text(
                "TASK-WAN",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const Text(
                "Management App",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const Text(
                "Login to your account",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field required";
                      } else if (!mailRegex.hasMatch(value)) {
                        return "Email not valid";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefix: const SizedBox(
                        width: 10,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.065,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                          ),
                          child: const Icon(Icons.email, color: Colors.white),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field required";
                      } else if (value.length < 8) {
                        return "password must be at least 8 chars";
                      } else if (!passRegex.hasMatch(value)) {
                        return "password must have at least 1 uppercase and lowercase";
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      prefix: const SizedBox(
                        width: 10,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                      ),
                      hintText: "Password",
                      prefixIcon: Container(
                        height: MediaQuery.of(context).size.height * 0.065,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          ),
                        ),
                        child: const Icon(Icons.lock, color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Forgotpassword(),
                        );
                      });
                },
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              const Spacer(),
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
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final prefix.Either<Failure, bool> result =
                          await LoginUsecase(userAuthRepo).call(
                        emailController.text,
                        passwordController.text,
                      );
                      if (result.isLeft()) {
                        Failure? failure =
                            result.fold((failure) => failure, (_) => null);
                        if (failure != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                failure.errMessage,
                              ),
                            ),
                          );
                        }
                      } else {
                        ref.refresh(userStateProvider);
                        Future.delayed(const Duration(microseconds: 1000), () {
                          Navigator.of(context).pushNamed('home');
                        });
                      }
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t have an account?",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('signUp');
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
