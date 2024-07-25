import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';
import 'package:task_manager/features/auth/domain/usecases/login.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  final emailConroller = TextEditingController();
  final passwordController = TextEditingController();
  final userAuthrepo = UserAuthRepositoryImplementation(RemoteAuth());

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
                  fontSize: 35),
            ),
            const Text(
              "Management  App",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            const Text(
              "Login to your account",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            style: BorderStyle.solid, color: Colors.blue),
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: emailConroller,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.075,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () async {
                    Either<Failure, bool> result =
                        await LoginUsecase(userAuthrepo)
                            .call(emailConroller.text, passwordController.text);
                    if (result.isLeft()) {
                      print(result);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login failed')),
                      );
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
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
                      Navigator.of(context).pushNamed('Signup');
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
