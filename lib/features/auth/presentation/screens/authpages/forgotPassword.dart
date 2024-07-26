import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/repositories/user_auth_repository_implementation.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/usecases/resetpassword.dart';
import 'package:task_manager/features/auth/presentation/screens/authpages/Signup.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final UserAuthRepositoryImplementation _userAuthRepositoryImplementation =
      UserAuthRepositoryImplementation(RemoteAuth());
  final emailController = TextEditingController();
  final RegExp mailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textField(
              formValidator: (val) {
                if (val!.isEmpty) {
                  return "Email cannot be empty";
                }
                if (!mailRegex.hasMatch(val)) {
                  return "Invalid email";
                }
                return null;
              },
              hintText: "Email",
              icon: Icons.email,
              controller: emailController,
              blueColor: Colors.blue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.blue)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dartz.Either<Failure, void> result =
                            await ResetpasswordUsecase(
                                    _userAuthRepositoryImplementation)
                                .call(emailController.text);
                        result.fold((l) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l.errMessage),
                            ),
                          );
                        }, (r) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Password reset link sent to ${emailController.text}"),
                            ),
                          );

                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
