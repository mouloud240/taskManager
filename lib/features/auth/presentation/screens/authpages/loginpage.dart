import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as prefix;
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/usecases/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userAuthRepo = UserAuthRepositoryImplementation(RemoteAuth());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email  ",
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
                      child: const Icon(Icons.email, color: Colors.white),
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
                  controller: passwordController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
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
              onPressed: () {},
              child: const Text(
                "Forgot password?",
                style: TextStyle(color: Colors.blue, fontSize: 15),
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
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                onPressed: () async {
                  final prefix.Either<Failure, bool> result =
                      await LoginUsecase(userAuthRepo).call(
                    emailController.text,
                    passwordController.text,
                  );
                  if (result.isLeft()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Login failed",
                        ),
                      ),
                    );
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
          ],
        ),
      ),
    );
  }
}
